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
## logging
##

class Log
  def self.d(tag, msg)
    Log.log(:debug, tag, msg)
  end

  def self.i(tag, msg)
    Log.log(:info, tag, msg)
  end

  def self.w(tag, msg)
    Log.log(:warn, tag, msg)
  end

  def self.e(tag, msg)
    Log.log(:error, tag, msg)
  end

  def self.f(tag, msg)
    Log.log(:fatal, tag, msg)
  end

  def self.a(tag, msg)
    Log.log(:unknown, tag, msg)
  end

  private

  def self.log(method = :info, tag = 'NONE', msg = '')
    logger = Rumudge.environment.logger

    begin
      lm = logger.method(method)
      lm.call("[#{tag}] > #{msg}")
    rescue
      logger.warn("Can't log message with method #{method}")
    end
  end
end
