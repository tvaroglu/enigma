require 'date'
require_relative 'spec_helper'

RSpec.describe Enigma do

  xit 'initializes' do
    enigma = Enigma.new

    expect(enigma.class).to eq(Enigma)
    expect(enigma.alpha_arr.class).to eq(Array)
    expect(enigma.alpha_arr.length).to eq(27)

    data_validation = enigma.alpha_arr.each_with_object(Hash.new(0)) do |char, hash|
      hash[char] += 1
    end

    expect(data_validation.keys.length).to eq(27)
    expect(data_validation.values.all? { |val| val == 1 }).to be true
  end

  xit 'can encrpyt a message with a date' do
    enigma = Enigma.new
    key = KeyGen.new('02715')
    date = '040895'

    encryption = enigma.encrypt('HELLO WORLD!', key.reveal[0], date)

    expect(encryption.class).to eq(Hash)
    expect(encryption.keys.length).to eq(3)
    expect(encryption.values.length).to eq(3)

    expect(encryption[:encryption]).to eq('keder ohulw!')
    expect(encryption[:key]).to eq('02715')
    expect(encryption[:date]).to eq('040895')
  end

  xit 'can decrypt a message with a date' do
    enigma = Enigma.new
    key = KeyGen.new('02715')
    date = '040895'

    decryption = enigma.decrypt('keder ohulw!', key.reveal[0], date)

    expect(decryption.class).to eq(Hash)
    expect(decryption.keys.length).to eq(3)
    expect(decryption.values.length).to eq(3)

    expect(decryption[:decryption]).to eq('hello world!')
    expect(decryption[:key]).to eq('02715')
    expect(decryption[:date]).to eq('040895')
  end

  xit "can encrpyt a message with today's date" do
    enigma = Enigma.new
    key = KeyGen.new('02715')
    allow(Date).to receive(:today).and_return('2021-06-11')

    encryption = enigma.encrypt('HELLO WORLD!', key.reveal[0])

    expect(encryption.class).to eq(Hash)
    expect(encryption.keys.length).to eq(3)
    expect(encryption.values.length).to eq(3)

    expect(encryption[:encryption]).to eq('keder ohulw!')
    expect(encryption[:key]).to eq('02715')
    expect(encryption[:date]).to eq('110621')
  end

  xit "can decrypt a message with today's date" do
    enigma = Enigma.new
    key = KeyGen.new('02715')
    allow(Date).to receive(:today).and_return('2021-06-11')

    decryption = enigma.decrypt('keder ohulw!', key.reveal[0])

    expect(decryption.class).to eq(Hash)
    expect(decryption.keys.length).to eq(3)
    expect(decryption.values.length).to eq(3)

    expect(decryption[:decryption]).to eq('hello world!')
    expect(decryption[:key]).to eq('02715')
    expect(decryption[:date]).to eq('110621')
  end

  xit "can encrpyt a message with a random key and today's date" do
    enigma = Enigma.new
    key = KeyGen.new
    key.instance_variable_set(:@key, '02715')
    # stubbed value based on '2021-06-11' as "today's date"
    key.instance_variable_set(:@offsets, '5641')

    encryption = enigma.encrypt('HELLO WORLD!')

    expect(encryption.class).to eq(Hash)
    expect(encryption.keys.length).to eq(3)
    expect(encryption.values.length).to eq(3)

    expect(encryption[:encryption]).to eq('keder ohulw!')
    expect(encryption[:key]).to eq('02715')
    expect(encryption[:date]).to eq('110621')
  end

  xit "can decrypt a message with a random key and today's date" do
    enigma = Enigma.new
    key = KeyGen.new
    key.instance_variable_set(:@key, '02715')
    # stubbed value based on '2021-06-11' as "today's date"
    key.instance_variable_set(:@offsets, '5641')

    encryption = enigma.encrypt('HELLO WORLD!')
    decryption = enigma.decrypt(encryption[:encryption])

    expect(decryption.class).to eq(Hash)
    expect(decryption.keys.length).to eq(3)
    expect(decryption.values.length).to eq(3)

    expect(decryption[:decryption]).to eq('keder ohulw!')
    expect(decryption[:key]).to eq('02715')
    expect(decryption[:date]).to eq('110621')
  end

end
