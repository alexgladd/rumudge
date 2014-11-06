##
## main server controller
##

require 'socket'

class Rumudge::Server
  TAG = 'Server'

  # constructor
  def initialize(addr = '0.0.0.0', port = 4323, options = { env: :development })
    @addr = addr
    @port = port
    @client_pool = []
    
    set_environment(options[:env])
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

  private

  def set_environment(env)
    if env.to_s.upcase == 'PROD' || env.to_s.upcase == 'PRODUCTION'
      Log.i(TAG, 'Setting environment to production')
      Rumudge::Environment.production
    end
  end
end
