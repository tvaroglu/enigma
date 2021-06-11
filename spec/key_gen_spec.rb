require_relative 'spec_helper'

RSpec.describe KeyGen do

  xit 'initializes' do
    # need to change initialize to take arg, randomize if none
    key = KeyGen.new

    expect(key.class).to eq(KeyGen)

    expect(key.reveal.class).to eq(Array)
    expect(key.reveal.length).to eq(2)
    expect(key.reveal.first.class).to eq(String)
    expect(key.reveal.first.length).to eq(5)
    expect(key.reveal.last).to eq('')
  end

  it 'can generate random integer keys' do
    key1 = KeyGen.new
    key2 = KeyGen.new

    expect(key1.reveal[0]).not_to eq(key2.reveal[0])
  end

  it 'can return date offsets based on date of message transmission' do
    key = KeyGen.new
    allow(Date).to receive(:today).and_return('2021-06-11')
    today = Date.today
    another_day = '040895'

    a_string = 'hello!'
    invalid_date = '000000'
    another_invalid_date = 1231231231231

    expected_default_return_values = [
      key.return_offsets(today),
      key.return_offsets,
      key.return_offsets(a_string),
      key.return_offsets(invalid_date),
      key.return_offsets(another_invalid_date)
    ]
    expect(expected_default_return_values.all? { |result| result == '5641' }).to be true

    expected_custom_return_value = key.return_offsets(another_day)
    expect(expected_custom_return_value).to eq('1025')
  end

  it 'can return total shifts based on key and date offsets' do
    key = KeyGen.new
    key.instance_variable_set(:@key, '02715')
    key.instance_variable_set(:@offsets, '1025')

    expect(key.reveal[0]).to eq('02715')
    expect(key.reveal[1]).to eq('1025')

    expected = key.return_shifts

    expect(expected.class).to eq(Hash)
    expect(expected.keys.length).to eq(4)
    expect(expected[:a]).to eq(3)
    expect(expected[:b]).to eq(27)
    expect(expected[:c]).to eq(73)
    expect(expected[:d]).to eq(20)
  end

end
