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
## the rumudge api
##

require_relative 'util'
require_relative 'env'
require_relative 'log'
require_relative 'net/server'
require_relative 'net/session'
require_relative 'ctrl/controller'
require_relative 'ctrl/default_controller'
require_relative 'sys/roll'
require_relative 'mud/entity'
require_relative 'mud/creature'

# init the startup controller
Rumudge.environment.startup_ctrl = Rumudge::DefaultController
