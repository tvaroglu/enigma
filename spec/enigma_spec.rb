require_relative 'spec_helper'

RSpec.describe Enigma do

  it 'initializes' do
    enigma = Enigma.new

    expect(enigma.class).to eq(Enigma)
    expect(enigma.alpha_arr.class).to eq(Array)
    expect(enigma.alpha_arr.length).to eq(27)

    data_validation = enigma.alpha_arr.each_with_object({}) do |char, hash|
      hash[char] = true
    end

    expect(data_validation.keys.length).to eq(27)
    expect(data_validation.values.length).to eq(27)
    expect(data_validation.values.all? { |val| val == true }).to be true
  end

  it 'can encrpyt a message with a key and date' do
    enigma = Enigma.new
    key = KeyGen.new('02715')
    date = '040895'

    encryption = enigma.encrypt('HELLO WORLD!', key.reveal, date)

    expect(encryption.class).to eq(Hash)
    expect(encryption.keys.length).to eq(3)
    expect(encryption.values.length).to eq(3)

    expect(encryption[:encryption]).to eq('keder ohulw!')
    expect(encryption[:key]).to eq(key.reveal)
    expect(encryption[:date]).to eq(date)
  end

  it 'can decrypt a message with a key and date' do
    enigma = Enigma.new
    key = KeyGen.new('02715')
    date = '040895'

    encryption = enigma.encrypt('HELLO_WORLD!', key.reveal, date)
    decryption = enigma.decrypt(encryption[:encryption], encryption[:key], encryption[:date])

    expect(decryption.class).to eq(Hash)
    expect(decryption.keys.length).to eq(3)
    expect(decryption.values.length).to eq(3)

    expect(decryption[:decryption]).to eq('hello_world!')
    expect(decryption[:key]).to eq(key.reveal)
    expect(decryption[:date]).to eq(date)
  end

  it 'can encrpyt a message without a date (by using Date.today)' do
    enigma = Enigma.new
    key = KeyGen.new('02715')
    # key.date stub based on '2021-06-11' as "today's date"
    key.instance_variable_set(:@date, '110621')

    encryption = enigma.encrypt('hello world', key.reveal)

    expect(encryption.class).to eq(Hash)
    expect(encryption.keys.length).to eq(3)
    expect(encryption.values.length).to eq(3)

    expect(encryption[:encryption]).to eq('okfavfqdyry')
    expect(encryption[:key]).to eq(key.reveal)
    expect(encryption[:date]).to eq(key.date)
  end

  it 'can decrypt a message without a date (by using Date.today)' do
    enigma = Enigma.new
    key = KeyGen.new('02715')
    # key.date stub based on '2021-06-11' as "today's date"
    key.instance_variable_set(:@date, '110621')

    encryption = enigma.encrypt('hello world', key.reveal)
    decryption = enigma.decrypt(encryption[:encryption], encryption[:key])

    expect(decryption.class).to eq(Hash)
    expect(decryption.keys.length).to eq(3)
    expect(decryption.values.length).to eq(3)

    expect(decryption[:decryption]).to eq('hello world')
    expect(decryption[:key]).to eq(key.reveal)
    expect(decryption[:date]).to eq(key.date)
  end

  xit "can encrpyt a message with a random key and today's date" do
    enigma = Enigma.new
    key = KeyGen.new
    key.instance_variable_set(:@key, '02715')
    # key.date stub based on '2021-06-11' as "today's date"
    key.instance_variable_set(:@date, '110621')

    encryption = enigma.encrypt('HELLO WORLD!')

    expect(encryption.class).to eq(Hash)
    expect(encryption.keys.length).to eq(3)
    expect(encryption.values.length).to eq(3)

    expect(encryption[:encryption]).to eq('okfavfqdyry!')
    expect(encryption[:key]).to eq(key.reveal)
    expect(encryption[:date]).to eq(key.date)
  end

  xit "can decrypt a message with a random key and today's date" do
    enigma = Enigma.new
    key = KeyGen.new
    key.instance_variable_set(:@key, '02715')
    # key.date stub based on '2021-06-11' as "today's date"
    key.instance_variable_set(:@date, '110621')

    encryption = enigma.encrypt('HELLO WORLD!')
    decryption = enigma.decrypt(encryption[:encryption])

    expect(decryption.class).to eq(Hash)
    expect(decryption.keys.length).to eq(3)
    expect(decryption.values.length).to eq(3)

    expect(decryption[:decryption]).to eq('hello world!')
    expect(decryption[:key]).to eq(key.reveal)
    expect(decryption[:date]).to eq(key.date)
  end

end
