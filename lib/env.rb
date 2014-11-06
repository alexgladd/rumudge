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

module Rumudge
  class Environment
    DEVELOPMENT = :development
    PRODUCTION = :production

    def initialize(env = DEVELOPMENT, logger = Logger.new(STDOUT))
      @env = env
      @logger = logger

      setup
    end

    def logger
      @logger
    end

    def logger=(logger)
      unless logger.is_a? Logger
        raise ArgumentError, 'Argument must be a Logger object'
      end

      @logger = logger

      setup
    end

    def is_production?
      @env == PRODUCTION
    end

    def is_development?
      @env == DEVELOPMENT
    end

    private

    def setup
      if is_production?
        @logger.level = Logger::WARN
      end
    end
  end

  # our environment
  @@env = Rumudge::Environment.new

  def self.environment
    @@env
  end

  def self.environment=(env)
    unless env.is_a? Rumudge::Environment
      raise ArgumentError, 'Argument must be a Rumudge::Environment object'
    end

    @@env = env
  end
end
