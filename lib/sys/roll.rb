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
## Emulate randomized dice rolling
##

require 'securerandom'

class Roll
  # contructor
  def initialize(num = 1, sides = 6)
    unless num > 0 && sides > 0
      raise ArgumentError, 'Num and Sides must be greater than or equal to 1'
    end

    @rolls = []

    num.times do
      @rolls << SecureRandom.random_number(sides) + 1
    end

    @sum = @rolls.reduce(:+)
  end

  # represent the roll as a string
  def to_s
    "(#{@rolls.join(' + ')}) = #{@sum}"
  end

  # represent the roll as an integer sum
  def to_i
    @sum
  end

  # shortcut for creating rolls in the format "MdN", where
  #   M = number of dice
  #   N = number of sides
  def self.generate(roll)
    unless roll.is_a? String
      raise RumudgeError, 'The roll must be defined as a String (e.g., "2d8")'
    end

    parts = roll.split('d')

    if parts.length < 2
      raise RumudgeError, 'The roll must be in the format MdN (e.g., "2d8")'
    else
      Roll.new(parts[0].to_i, parts[1].to_i)
    end
  end
end