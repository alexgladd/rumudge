require 'rspec'

describe 'Roll' do

  let(:roll_default) { Roll.new() }
  let(:roll_1d20) { Roll.new(1, 20) }

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
