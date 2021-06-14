require_relative 'spec_helper'

RSpec.describe FileHandler do

  it 'can write a message to encrypt' do
    path = './lib/test_files/message.txt'
    message = 'der krieg endet heute end'
    allow(FileHandler).to receive(:retrieve_message).and_return(message)
    FileHandler.write_message(path)

    expect(FileHandler.retrieve_message).to eq(message)
    message_text = File.open(path, 'r')
    expect(message_text.read).to eq(message)
    message_text.close
  end

  it 'can encrypt a message' do
    message_file = './lib/test_files/message.txt'
    message = 'der krieg endet heute end'
    key = '67929'
    date = '130621'
    encryption_file = './lib/test_files/encrypted.txt'

    runner = FileHandler.encrypt(message_file, encryption_file, key, date)
    expect(runner).to eq("Created '#{File.basename(encryption_file)}' with the key #{key} and date #{date}")

    encrypted_text = File.open(encryption_file, 'r')
    decryption = Enigma.new.decrypt(encrypted_text.read, key, date)
    encrypted_text.close

    expect(decryption[:decryption]).to eq(message)
    expect(decryption[:key]).to eq(key)
    expect(decryption[:date]).to eq(date)
  end

  it 'can decrypt a message' do
    encryption_file = './lib/test_files/encrypted.txt'
    message = 'der krieg endet heute end'
    key = '67929'
    date = '130621'
    decryption_file = './lib/test_files/message.txt'

    runner = FileHandler.decrypt(encryption_file, decryption_file, key, date)
    expect(runner).to eq("Created '#{File.basename(decryption_file)}' with the key #{key} and date #{date}")

    decrypted_text = File.open(decryption_file, 'r')
    expect(decrypted_text.read).to eq(message)
    decrypted_text.close
  end

  it 'can crack an encrypted message' do
    encryption_file = './lib/test_files/encrypted.txt'
    message = 'der krieg endet heute end'
    key = '67929'
    date = '130621'
    cracked_file = './lib/test_files/cracked.txt'

    runner = FileHandler.crack(encryption_file, cracked_file, date)
    expect(runner).to eq("Created '#{File.basename(cracked_file)}' with the key #{key} and date #{date}")

    cracked_text = File.open(cracked_file, 'r')
    expect(cracked_text.read).to eq(message)
    cracked_text.close
  end

end
