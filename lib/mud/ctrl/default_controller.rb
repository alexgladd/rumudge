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
## basic default controller
##

class Rumudge::DefaultController < Rumudge::Controller
  TAG = 'DefaultController'

  # before_start :cb_1
  # before_command :cb_2
  # after_command :cb_3
  # before_stop :cb_4

  def initialize
    super
  end

  def process_command
    @response = "Received command='#{command}' params=[#{params.join(', ')}]\n"
  end

  private

  def cb_1
    Log.d(TAG, "#{self} Exec callback 1")
  end

  def cb_2
    Log.d(TAG, "#{self} Exec callback 2")
  end

  def cb_3
    Log.d(TAG, "#{self} Exec callback 3")
  end

  def cb_4
    Log.d(TAG, "#{self} Exec callback 4")
  end
end
