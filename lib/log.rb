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
    self.log(:debug, tag, msg)
  end

  def self.i(tag, msg)
    self.log(:info, tag, msg)
  end

  def self.w(tag, msg)
    self.log(:warn, tag, msg)
  end

  def self.e(tag, msg)
    self.log(:error, tag, msg)
  end

  def self.f(tag, msg)
    self.log(:fatal, tag, msg)
  end

  def self.a(tag, msg)
    self.log(:unknown, tag, msg)
  end

  private

  def self.log(method = :info, tag = 'NONE', msg = '')
    logger = Rumudge::Environment.logger

    begin
      lm = logger.method(method)
      lm.call("[#{tag}] > #{msg}")
    rescue
      logger.warn("Can't log message with method #{method}")
    end
  end
end
