# use rumudge
require_relative '../lib/rumudge'

# define a controller subclass
class MyController < Rumudge::Controller
  # use rails-style callbacks to setup command handling
  permitted_commands :hello, :quit

  private

  # called to handle the 'hello' command
  def hello
    self.response = "Hello to you, too!\n"
  end

  # called to handle the 'quit' command
  def quit
    self.response = "Goodbye!\n"

    # call finish to signal that you're done
    finish
  end
end

# setup the environment to use your controller
Rumudge.environment.startup_ctrl = MyController

# instantiate and start a server
server = Rumudge::Server.new
server.start
