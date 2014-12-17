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
## base game creature (players, enemies, npcs, etc)
##

class Rumudge::Creature < Rumudge::Entity
  ABILITY_NAMES = [ :str, :dex, :con, :int, :wis, :cha ]
  STAT_HP = :hp

  attr_reader :name

  # constructor
  def initialize(id, name = 'Creature', options = {})
    super(id)

    @name = name

    @abilities = {}
    ABILITY_NAMES.each do |a|
      @abilities[a] = 1
    end

    @hp = 1

    self.parse_options(options)
  end

  private

  # parse incoming options
  def parse_options(options = {})
    # try abilities
    ABILITY_NAMES.each do |ability|
      if options.has_key? ability
        @abilities[ability] = options[ability]
      end
    end

    # stats
    if options.has_key? STAT_HP
      @hp = options[STAT_HP]
    end
  end
end
