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

##
## main server controller
##

require 'socket'

class Rumudge::Server
  # used for system-wide interrupts
  class Interrupt < ::Interrupt
    attr_reader :for_client
    def initialize(for_client = nil)
      super(2)
      @for_client = for_client
    end
  end

  TAG = 'Server'

  # constructor
  def initialize(addr = '0.0.0.0', port = 4323)
    @addr = addr
    @port = port
    @client_pool = []
    @client_pool_lock = Mutex.new
  end

  # start the server
  def start
    @run = true

    run_loop

    # wait on the main thread until Ctrl-C or run=false
    begin
      Log.a(TAG, 'Press Ctrl-C to shutdown the server')
      while @run
        sleep 1
      end
    rescue ::Interrupt
      Log.a(TAG, 'Starting shutdown...')
    end

    # stop accepting new connections
    Log.d(TAG, 'Stopping server loop')
    @run = false
    @acceptor.join

    Log.d(TAG, "Stopping #{client_count} connected clients")
    broadcast('Server is shutting down NOW!')
    stop_clients

    Log.a(TAG, 'Server shutdown')
  end

  def broadcast(message)
    return if message.nil?

    # send message to each client
    @client_pool_lock.synchronize {
      @client_pool.each do |c|
        c.write("[SERVER BROADCAST] >> #{message}\n")
      end
    }
  end

  def on_client_close(session)
    @client_pool_lock.synchronize {
      @client_pool.delete(session)
    }

    Log.i(TAG, "Client session closed from #{session.remote_addr}")
  end

  private

  def client_count
    @client_pool_lock.synchronize {
      @client_pool.length
    }
  end

  def run_loop
    # start new thread for the accept loop
    @acceptor = Thread.new do
      Log.a(TAG, "Server started => #{@addr}:#{@port}")
      server = TCPServer.new(@addr, @port)

      while @run
        # emulate a blocking accept
        begin
          sock = server.accept_nonblock
          Log.i(TAG, "New client connection from #{sock.peeraddr[-1]}")

          # TODO use the new socket
          session = Rumudge::Session.new(sock, self)
          session.start

          @client_pool_lock.synchronize {
            @client_pool << session
          }
        rescue IO::WaitReadable, Errno::EINTR
          IO.select([server], nil, nil, 0.5)
        end
      end

      server.close
    end
  end

  def stop_clients
    # request shutdown of all clients
    @client_pool_lock.synchronize {
      @client_pool.each do |c|
        c.stop
      end
    }

    start_wait = Time.now

    while client_count > 0
      sleep 0.25

      if Time.now - start_wait > 3.0
        break
      end
    end
  end
end
