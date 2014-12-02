#!/usr/bin/env ruby

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
## main entry point for the game
##

# ensure we're using dev code
require_relative '../lib/rumudge'
require_relative 'test_controller'

Log.a('Test Main', 'Setting up environment')

Rumudge.environment.startup_ctrl = TestController

Log.a('Test Main', 'Starting TEST RuMUDGE server...')

server = Rumudge::Server.new()

server.start