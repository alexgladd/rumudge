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

describe 'Environment' do

  let(:env_default) { Rumudge::Environment.new }
  let(:env_prod) { Rumudge::Environment.new(Rumudge::Environment::PRODUCTION) }

  it 'should default to the development environment' do
    expect(env_default.is_development?).to be true
  end

  it 'should be able to be initialized in production mode' do
    expect(env_prod.is_production?).to be true
  end

  it 'should start with no default controller' do
    expect(env_default.startup_ctrl).to be nil
  end

  it 'should start with a logger' do
    expect(env_default.logger).to be_a(Logger)
  end

  it 'should raise an error when setting a bad logger' do
    expect { env_default.logger = 'foobar' }.to raise_error(ArgumentError)
  end

  it 'should raise an error when setting a bad startup controller' do
    expect { env_default.startup_ctrl = 'foobar' }.to raise_error(ArgumentError)
  end
end