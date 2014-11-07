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

  def initialize(socket)
    unless socket.is_a? IPSocket
      raise ArgumentError, 'Argument must be a IPSocket object'
    end

    @socket = socket
    @socket_lock = Mutex.new
    @run = false
    @run_lock = Mutex.new
  end

  def read
    begin
      cmd = @socket_lock.synchronize {
        @socket.gets($/, 256).chomp
      }

      Log.d(TAG, "Read from socket: #{cmd}")

      cmd
    rescue IOError => e
      Log.e(TAG, 'IO failure while reading from socket: #{e.message}')
      nil
    end
  end

  def write(response)
    return false if response.nil?

    begin
      @socket_lock.synchronize {
        Log.d(TAG, "Writing to socket: #{response}")
        @socket.puts(response)
      }

      true
    rescue IOError => e
      Log.e(TAG, "IO failure while writing to socket: #{e.message}")
      false
    end
  end

  def start
    @run_lock.synchronize {
      @run = true
    }

    @loop = Thread.new do
      # main loop for the session
      while run?
        begin
          # wait on input from the client
          cmd = read

          # TODO
          Log.i(TAG, "Processing command '#{cmd}'")
        rescue Rumudge::Server::Interrupt => i
          # handle interrupts from the server
          Log.i(TAG, "Caught server interrupt in #{Thread.current}")
          write i.for_client
        end
      end
    end
  end

  def stop
    @run_lock.synchronize {
      @run = false
    }
  end

  private

  def run?
    @run_lock.synchronize {
      @run
    }
  end
end
