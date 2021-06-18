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

    encryption = enigma.encrypt('HELLO WORLD!', key.reveal, date)
    decryption = enigma.decrypt(encryption[:encryption], encryption[:key], encryption[:date])

    expect(decryption.class).to eq(Hash)
    expect(decryption.keys.length).to eq(3)
    expect(decryption.values.length).to eq(3)

    expect(decryption[:decryption]).to eq('hello world!')
    expect(decryption[:key]).to eq(key.reveal)
    expect(decryption[:date]).to eq(date)
  end

  it 'can encrpyt/decrypt a message without a date (by using Date.today)' do
    enigma = Enigma.new
    key = KeyGen.new('02715')
    message = 'hello_world'

    encryption = enigma.encrypt(message, key.reveal)
    # Note, could stub key and date within the encryption process, to ensure
    #known date and keys are returned (this is a good integeration test example,
    #but NOT a good unit test)
    decryption = enigma.decrypt(encryption[:encryption], encryption[:key])

    expect(decryption[:decryption]).to eq(message)
    expect(decryption[:key]).to eq(key.reveal)
    expect(decryption[:date]).to eq(key.date)
  end

  it "can encrypt/decrypt a message with a random key and today's date" do
    enigma = Enigma.new
    message = 'taylor is a hacker!!!'

    encryption = enigma.encrypt(message)
    decryption = enigma.decrypt(encryption[:encryption], encryption[:key])

    expect(decryption[:decryption]).to eq(message)
    expect(decryption[:key]).to eq(encryption[:key])
    expect(decryption[:date]).to eq(encryption[:date])
  end

  it 'can crack an encrypted message with a date' do
    enigma = Enigma.new
    key = KeyGen.new('08304')
    message = 'hello world end'
    date = '291018'

    encryption = enigma.encrypt(message, key.reveal, date)
    expect(encryption[:encryption]).to eq('vjqtbeaweqihssi')

    cracked = enigma.crack(encryption[:encryption], encryption[:date])
    expect(cracked[:decryption]).to eq(message)
    expect(cracked[:key]).to eq(encryption[:key])
    expect(cracked[:date]).to eq(encryption[:date])
  end

  it "can crack an encrypted message with today's date" do
    enigma = Enigma.new
    key = KeyGen.new('08304')
    message = 'hello world end'

    encryption = enigma.encrypt(message, key.reveal)
    cracked = enigma.crack(encryption[:encryption])

    expect(cracked[:decryption]).to eq(message)
    expect(cracked[:key]).to eq(encryption[:key])
    expect(cracked[:date]).to eq(encryption[:date])
  end

end
