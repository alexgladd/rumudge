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

require 'rspec'

describe 'Creature' do

  let(:options_hp) {
    { str: 18, dex: 15, con: 13, int: 11, wis: 9, cha: 5, hp: 10, ac: 12 }
  }

  let(:options_hitd) {
    { str: 18, dex: 15, con: 13, int: 11, wis: 9, cha: 5, hitd: '2d8', attack_mod: :dex }
  }

  let(:c_hp) { Rumudge::Creature.new(1, 'Test', options_hp) }
  let(:c_hitd) { Rumudge::Creature.new(1, 'Test', options_hitd) }

  it 'should parse the correct ability scores' do
    expect(c_hp.ability_score(:str)).to eql(18)
    expect(c_hp.ability_score(:int)).to eql(11)
  end

  it 'should raise an error for a bad ability key' do
    expect { c_hp.ability_score(:foobar) }.to raise_error(ArgumentError)
  end

  it 'should produce the correct ability modifiers' do
    expect(c_hp.ability_mod(:str)).to eql(4)
    expect(c_hp.ability_mod(:cha)).to eql(-3)
  end

  it 'should produce the correct ability checks' do
    100.times do
      expect(c_hp.ability_check(:str)).to be_between(5, 24).inclusive
    end
  end

  it 'should parse hp when given explicity hp' do
    expect(c_hp.hp).to eql(10)
  end

  it 'should set hp correctly if given a hit dice value' do
    expect(c_hitd.hp).to eql(17)
  end

  it 'should parse the correct armor class' do
    expect(c_hp.ac).to eql(12)
  end

  it 'should parse the correct attack modifier' do
    expect(c_hitd.attack_mod).to eql(2)
  end
end
