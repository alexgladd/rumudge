require 'rspec'

describe 'Entity' do

  let(:entity) { Rumudge::Entity.new(1234) }

  it 'should save its ID' do
    expect(entity.id).to eql(1234)
  end
end