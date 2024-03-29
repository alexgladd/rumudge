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
## test controller
##

# ensure we're using dev code
require_relative '../lib/rumudge'

class TestController < Rumudge::Controller
  TAG = 'TestController'

  # Setup the controller with rails-style callbacks

  # This is how we setup lifecycle callbacks
  # Use comma-separated list of symbols that correspond to methods
  before_start :welcome
  before_command :before_cmd
  after_command :after_cmd
  before_stop :stopping

  # Define a list of commands that the controller can respond to
  # Use a comma-separated list of symbols that correspond to methods
  permitted_commands :quit

  # Use a regular expression to match command(s)
  # The second parameter should be a symbol that corresponds to a method
  match_commands /.+/, :catch_all

  private

  def quit
    Log.d(TAG, 'Client requested quit!')
    self.response = "Goodbye!\n"
    finish
  end

  def catch_all
    Log.d(TAG, "Processing '#{command}' in catch-all")
    self.response = "Received command='#{command}' params=[#{params.join(', ')}]\n\n> "
  end

  def welcome
    Log.d(TAG, 'Exec welcome callback')
    session.write "\nWelcome to the test controller!\nEnter 'quit' to disconnect!\n\n> "
  end

  def before_cmd
    Log.d(TAG, 'Callback: before command')
  end

  def after_cmd
    Log.d(TAG, 'Callback: after command')
  end

  def stopping
    Log.d(TAG, 'Callback: controller stopping')
  end
end


# Run the test controller
Log.a('Test Main', 'Setting up environment')

Rumudge.environment.startup_ctrl = TestController

Log.a('Test Main', 'Starting TEST RuMUDGE server...')

server = Rumudge::Server.new()

server.start
