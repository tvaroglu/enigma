require_relative 'spec_helper'

RSpec.describe KeyGen do

  it 'initializes' do
    key = KeyGen.new

    expect(key.class).to eq(KeyGen)
    expect(key.key.class).to eq(String)
    expect(key.key.length).to eq(5)
  end

  it 'can generate random integer sequences' do
    key1 = KeyGen.new
    key2 = KeyGen.new

    expect(key1.key).not_to eq(key2.key)
  end

end
