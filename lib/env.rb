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
## environment
##

require 'logger'

class Rumudge::Environment
  @@current = :development
  @@logger = Logger.new(STDOUT)

  def self.is_production?
    @@current == :production
  end

  def self.is_development?
    @@current == :development
  end

  def self.production
    @@current = :production

    # log level to warn
    @@logger.level = Logger::WARN
  end

  def self.logger
    @@logger
  end

  def self.logger=(logger)
    unless logger.is_a? Logger
      raise ArgumentError, 'Argument must be a Logger object'
    end

    @@logger = logger

    if self.is_production?
      @@logger.level = Logger::WARN
    end
  end
end
