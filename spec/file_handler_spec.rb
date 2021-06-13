require_relative 'spec_helper'

RSpec.describe FileHandler do
  after :each do
    @message = 'foobar'
    @path = './lib/message.txt'
    @file = File.open(@path, 'r')

    if @file.read != @message
      @file = File.open(@path, 'w')
      @file.write(@message)
    end

    @file.close
  end

  xit 'can write a message to encrypt' do
    path = './lib/message.txt'
    message = 'foobar'
    FileHandler.write_message(path)

    file = File.open(path, 'r')
    expect(file.read).to eq(message)
    file.close
  end

  it 'can encrypt a message' do
    message_file = './lib/message.txt'
    message = 'foobar'
    key = '67929'
    date = '130621'

    encryption_file = './lib/encrypted.txt'
    encryption = Enigma.new.encrypt(message, key, date)
    expect(encryption[:encryption]).to eq('xscesv')

    runner = FileHandler.encrypt(message_file, encryption_file)
    expect(runner).to eq("Created 'encrypted.txt' with the key #{encryption[:key]} and date #{encryption[:date]}")

    encrypted_text = File.open(encryption_file, 'r')
    expect(encrypted_text.read).to eq(encryption[:encryption])
    encrypted_text.close

    message_text = File.open(message_file, 'r')
    expect(message_text.read).to eq(message)
    message_text.close
  end

  it 'can decrypt a message' do
    encryption_file = './lib/encrypted.txt'
    ciphertext = 'xscesv'
    key = '67929'
    date = '130621'

    decryption_file = './lib/decrypted.txt'
    decryption = Enigma.new.decrypt(ciphertext, key, date)
    expect(decryption[:decryption]).to eq('foobar')

    runner = FileHandler.decrypt(encryption_file, decryption_file, key, date)
    expect(runner).to eq("Created 'decrypted.txt' with the key #{decryption[:key]} and date #{decryption[:date]}")

    decrypted_text = File.open(decryption_file, 'r')
    expect(decrypted_text.read).to eq(decryption[:decryption])
    decrypted_text.close

    encrypted_text = File.open(encryption_file, 'r')
    expect(encrypted_text.read).to eq(ciphertext)
    encrypted_text.close
  end

end
