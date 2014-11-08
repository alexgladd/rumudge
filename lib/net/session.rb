# This file is part of the Rumudge gem
# Copyright (C) 2014 Alex Gladd
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'socket'

class Rumudge::Session
  TAG = 'Session'
  READ_LIMIT = 256

  attr_reader :remote_addr

  def initialize(socket, close_callback = nil)
    unless socket.is_a? IPSocket
      raise ArgumentError, 'Argument must be a IPSocket object'
    end

    @close_cb = close_callback
    @remote_addr = socket.peeraddr[-1]
    @socket = socket
    @socket_lock = Mutex.new
    @run = false
    @run_lock = Mutex.new
  end

  def read
    begin
      cmd = @socket_lock.synchronize {
        # check if we can read
        rdy = IO.select([@socket], nil, nil, 0.25)

        if rdy.nil?
          nil
        else
          # don't let people send huge chunks of data!
          @socket.read_nonblock(READ_LIMIT).chomp
        end
      }

      cmd
    rescue IOError => e
      Log.e(TAG, "IO failure while reading from socket: #{e.message}")

      # re-raise the error
      raise e
    end
  end

  def write(response)
    return false if response.nil?

    begin
      success = @socket_lock.synchronize {
        rdy = IO.select(nil, [@socket], nil, 0.1)

        if rdy.nil?
          false
        else
          @socket.write_nonblock(response)
          @socket.flush

          true
        end
      }

      Log.d(TAG, "Wrote to socket: '#{response}'") if success
      success
    rescue IOError => e
      Log.e(TAG, "IO failure while writing to socket: #{e.message}")
      # re-raise the error
      raise e
    end
  end

  def start
    @run_lock.synchronize {
      @run = true
    }

    run_loop
    Log.a(TAG, "Session started for client at #{@remote_addr}")
  end

  def stop(exp = nil)
    @run_lock.synchronize {
      @run = false
    }

    unless exp.nil?
      @loop.raise(exp)
    end
  end

  def running?
    @loop.alive?
  end

  private

  def run?
    @run_lock.synchronize {
      @run
    }
  end

  def run_loop
    # start a new thread to handle this session
    @loop = Thread.new do
      # main loop for the session
      while run?
        begin
          # check for socket errors
          ck_err = @socket_lock.synchronize {
            IO.select(nil, nil, [@socket], 0.0)
          }

          unless ck_err.nil?
            Log.e(TAG, "Detected socket error for #{@remote_addr} in #{Thread.current}")
            stop
            next
          end

          # try to read
          command = read

          # wait on input from the client
          if command.nil?
            # don't burn CPU
            sleep 0.25
          else
            # TODO
            Log.d(TAG, "Processing command '#{command}'")
          end

        rescue Rumudge::Server::Interrupt => i
          # handle interrupts from the server
          Log.i(TAG, "Caught server interrupt in #{Thread.current}")
          unless write(i.for_client)
            Log.e(TAG, 'Failed to write server interrupt message to client')
          end

        rescue IOError
          # a read or a write failed; interpret as socket failure and shut down
          Log.e(TAG, "Client socket error for #{@remote_addr}")
          stop

        end
      end

      # close down the connection
      @socket.close_read
      @socket.close_write

      if @close_cb.respond_to? :on_client_close
        @close_cb.on_client_close(self)
      end

      Log.a(TAG, "Session closing for client at #{@remote_addr}")
    end
  end
end
