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
## controller callbacks
##

module Rumudge::ControllerCallbacks
  # set callbacks for controller startup
  def before_start(*callbacks)
    @cb_on_start.replace(callbacks) unless callbacks.nil?
  end

  # set callbacks for before processing command
  def before_command(*callbacks)
    @cb_before_cmd.replace(callbacks) unless callbacks.nil?
  end

  # set callbacks for after command processing (before response to client)
  def after_command(*callbacks)
    @cb_after_cmd.replace(callbacks) unless callbacks.nil?
  end

  # set callbacks for controller shutdown
  def before_stop(*callbacks)
    @cb_on_stop.replace(callbacks) unless callbacks.nil?
  end
end
