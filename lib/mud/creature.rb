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
  attr_reader :name

  # constructor
  def initialize(id, name = nil, options = {})
    super(id)

    @name = name
    @abilities = { str: 1, dex: 1, con: 1, int: 1, wis: 1, cha: 1 }
  end

  private

  # parse incoming options
  def parse_options(options = {})

  end
end
