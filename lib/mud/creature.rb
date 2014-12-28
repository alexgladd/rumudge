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
  DEFAULT_ABILITIES = { str: 1, dex: 1, con: 1, int: 1, wis: 1, cha: 1 }
  DEFAULT_STATS = { hp: 1, ac: 8 }
  DEFAULT_OPTIONS = { hitd: nil }

  attr_reader :name

  # constructor
  def initialize(id, name = 'Creature', options = {})
    super(id)

    @name = name

    @abilities = parse_options(DEFAULT_ABILITIES, options)
    @stats = parse_options(DEFAULT_STATS, options)
    @options = parse_options(DEFAULT_OPTIONS, options)

    # set initial hp based on hit dice if we have it
    unless @options[:hitd].nil?
      r = Roll.generate(@options[:hitd])
      @stats[:hp] = (r.sides * r.num_rolls) + ability_mod(:con)
    end
  end

  # get an ability score
  def ability_score(ability)
    val = @abilities[ability]
    if val.nil?
      raise ArgumentError, "Unknown ability: #{ability.to_s}"
    end

    val
  end

  # get an ability modifier
  def ability_mod(ability)
    ((ability_score(ability) - 10.0) / 2.0).floor
  end

  # get an ability check
  def ability_check(ability)
    mod = ability_mod(ability)
    Roll.generate('1d20').to_i + mod
  end

  # get current hp
  def hp
    @stats[:hp]
  end

  # get current armor class
  def ac
    @stats[:ac]
  end

  private

  # filter incoming options with the given filter hash and return a hash of
  # filtered options
  def parse_options(filter, options = {})
    # filter options
    filtered = options.select { |key, v| filter.include? key }
    # merge and return results
    filter.merge(filtered)
  end
end
