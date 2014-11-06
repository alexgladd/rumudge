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
  TAG = 'Server'

  # constructor
  def initialize(addr = '0.0.0.0', port = 4323)
    @addr = addr
    @port = port
    @client_pool = []
  end

  # start the server
  def start
    @run = true

    # start new thread for the accept loop
    acceptor = Thread.new do
      Log.a(TAG, 'Server started')
      server = TCPServer.new(@addr, @port)

      while @run
        # emulate a blocking accept
        begin
          sock = server.accept_nonblock
          Log.a(TAG, "New client connection from #{sock.peeraddr[-1]}")

          # TODO use the new socket
          sleep 1
          sock.close_read
          sock.close_write
        rescue IO::WaitReadable, Errno::EINTR
          IO.select([server], nil, nil, 0.5)
        end
      end

      server.close
    end

    # wait on the main thread until Ctrl-C
    begin
      Log.a(TAG, 'Press Ctrl-C to shutdown the server')
      while @run
        sleep 1
      end
    rescue Interrupt
      Log.a(TAG, 'Starting shutdown...')
    end

    @run = false
    acceptor.join

    Log.a(TAG, 'Server shutdown')
  end
end
