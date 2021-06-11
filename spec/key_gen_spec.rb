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

  it 'can return date offsets based on date of message transmission' do
    key = KeyGen.new
    today = Date.today
    date = '040895'

    expected = key.reduce_date(today)
    expect(expected).to eq('5641')

    expected = key.reduce_date(date)
    expect(expected).to eq('1025')
  end

  it 'can return total shifts based on key and date offsets' do
    key = KeyGen.new
    allow(key).to receive(:key).and_return('02715')
    allow(key).to receive(:reduce_date).and_return('1025')

    expected = key.return_offsets

    expect(expected.class).to eq(Hash)
    expect(expected.keys.length).to eq(4)
    expect(expected['A']).to eq(3)
    expect(expected['B']).to eq(27)
    expect(expected['C']).to eq(73)
    expect(expected['D']).to eq(20)
  end

end
