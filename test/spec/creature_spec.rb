require 'rspec'

describe 'Creature' do

  let(:options_hp) {
    { str: 18, dex: 15, con: 13, int: 11, wis: 9, cha: 5, hp: 10 }
  }

  let(:options_hitd) {
    { str: 18, dex: 15, con: 13, int: 11, wis: 9, cha: 5, hitd: '1d8' }
  }

  it 'should parse the correct ability scores' do
    c = Rumudge::Creature.new(1, 'Test', options_hp)

    expect(c.ability_score(:str)).to eql(18)
    expect(c.ability_score(:int)).to eql(11)
  end

  it 'should produce the correct ability modifiers' do
    c = Rumudge::Creature.new(1, 'Test', options_hp)

    expect(c.ability_mod(:str)).to eql(4)
    expect(c.ability_mod(:cha)).to eql(-3)
  end

  # TODO more creature specs
end
