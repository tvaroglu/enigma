require_relative 'spec_helper'

RSpec.describe KeyGen do

  context '#initialize' do
    it 'with default param' do
      allow(Date).to receive(:today).and_return('2021-06-11')
      key = KeyGen.new

      expect(key.class).to eq(KeyGen)

      expect(key.reveal.class).to eq(String)
      expect(key.reveal.length).to eq(5)
      expect(key.date).to eq('110621')
    end

    it 'with passed in arg' do
      input_key = '02715'
      key = KeyGen.new(input_key)

      expect(key.class).to eq(KeyGen)
      expect(key.reveal).to eq(input_key)

      bad_key = 21412421352353225
      another_bad_key = 'hello'

      expectations = [
        KeyGen.new(bad_key).reveal,
        KeyGen.new(another_bad_key).reveal
      ]

      expect(expectations.all? do |expectation|
        expectation.class == String
        expectation.length == 5
        expectation != bad_key && expectation != another_bad_key
      end).to be true
    end


      it 'can generate keys randomly' do
        key1 = KeyGen.new
        key2 = KeyGen.new

        expect(key1.reveal).not_to eq(key2.reveal)
      end
  end


  context 'date offset and total shifts' do
    it 'can return date offsets based on date of message transmission' do
      key = KeyGen.new
      allow(Date).to receive(:today).and_return('2021-06-11')
      today = Date.today
      another_day = '040895'

      a_string = 'hello!'
      invalid_date = '000000'
      another_invalid_date = 1231231231231

      expectations = [
        key.set_offsets(today),
        key.set_offsets,
        key.set_offsets(a_string),
        key.set_offsets(invalid_date),
        key.set_offsets(another_invalid_date)
      ]
      expect(expectations.all? { |result| result == '5641' }).to be true

      expected = key.set_offsets(another_day)
      expect(expected).to eq('1025')
    end

    it 'can return total shifts based on key and date offsets' do
      key = KeyGen.new
      key.instance_variable_set(:@key, '02715')
      key.instance_variable_set(:@date, '040895')

      expect(key.reveal).to eq('02715')
      expect(key.date).to eq('040895')

      expected = key.return_shifts

      expect(expected.class).to eq(Hash)
      expect(expected.keys.length).to eq(4)
      expect(expected.values.length).to eq(4)
      expect(expected[:a]).to eq(3)
      expect(expected[:b]).to eq(27)
      expect(expected[:c]).to eq(73)
      expect(expected[:d]).to eq(20)
    end

    it "can return total shifts based on key and today's date offsets" do
      key = KeyGen.new
      key.instance_variable_set(:@key, '02715')
      # key.date stub based on '2021-06-11' as "today's date"
      key.instance_variable_set(:@date, '110621')

      expect(key.reveal).to eq('02715')
      expect(key.date).to eq('110621')

      expected = key.return_shifts

      expect(expected.class).to eq(Hash)
      expect(expected.keys.length).to eq(4)
      expect(expected.values.length).to eq(4)
      expect(expected[:a]).to eq(7)
      expect(expected[:b]).to eq(33)
      expect(expected[:c]).to eq(75)
      expect(expected[:d]).to eq(16)
    end
  end

end
