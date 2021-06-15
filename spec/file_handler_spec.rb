require_relative 'spec_helper'

RSpec.describe FileHandler do
  before :each do
    @message = 'hello world end'
    @message_file = './lib/test_files/message.txt'
    @encryption_file = './lib/test_files/encrypted.txt'
    @key = '67929'
    @date = '130621'
  end

  it 'can encrypt a message' do
    allow($stdin).to receive(:gets).and_return(@message)

    runner = FileHandler.encrypt(@message_file, @encryption_file, @key, @date)
    expect(runner).to eq("Created '#{File.basename(@encryption_file)}' with the key #{@key} and date #{@date}")

    message_text = File.open(@message_file, 'r')
    expect(message_text.read).to eq(@message)
    message_text.close

    encrypted_text = File.open(@encryption_file, 'r')
    decryption = Enigma.new.decrypt(encrypted_text.read, @key, @date)
    encrypted_text.close

    expect(decryption[:decryption]).to eq(@message)
  end

  it 'can decrypt a message' do
    decryption_file = './lib/test_files/decrypted.txt'

    runner = FileHandler.decrypt(@encryption_file, decryption_file, @key, @date)
    expect(runner).to eq("Created '#{File.basename(decryption_file)}' with the key #{@key} and date #{@date}")

    decrypted_text = File.open(decryption_file, 'r')
    expect(decrypted_text.read).to eq(@message)
    decrypted_text.close
  end

  it 'can crack an encrypted message' do
    cracked_file = './lib/test_files/cracked.txt'

    runner = FileHandler.crack(@encryption_file, cracked_file, @date)
    expect(runner).to eq("Created '#{File.basename(cracked_file)}' with the key #{@key} and date #{@date}")

    cracked_text = File.open(cracked_file, 'r')
    expect(cracked_text.read).to eq(@message)
    cracked_text.close
  end

end
