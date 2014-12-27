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

describe 'Roll' do

  context 'when generating rolls' do
    it 'should default to 1d6' do
      100.times do
        roll = Roll.new
        expect(roll.to_i).to be_between(1, 6).inclusive
      end
    end

    it 'should generate rolls in the correct range' do
      100.times do
        roll = Roll.new(1, 20)
        expect(roll.to_i).to be_between(1, 20).inclusive
      end

      100.times do
        roll = Roll.new(2, 8)
        expect(roll.to_i).to be_between(1, 16).inclusive
      end
    end

    it 'should record the correct number of dice' do
      roll = Roll.new(4, 6)

      expect(roll.num_rolls).to eql(4)
    end
  end

  context 'when using the generate shortcut' do
    it 'should generate the correct rolls' do
      100.times do
        roll = Roll.generate('1d20')
        expect(roll.to_i).to be_between(1, 20).inclusive
      end
    end

    it 'should raise an error for a bad roll string' do
      expect { Roll.generate('foobar') }.to raise_error(RumudgeError)
    end

    it 'should raise an error for a malformed roll string' do
      expect { Roll.generate('erdvvo') }.to raise_error
    end
  end
end
