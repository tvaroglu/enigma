require_relative 'enigma'

class FileHandler
  in_file, out_file, key, date = ARGV

  def self.write_message(message_file)
    file = File.open(message_file, 'w')
    puts "\nPlease enter a message to encrypt:\n > "
    message = $stdin.gets.chomp
    file.write(message.downcase)
    file.close
  end

  def self.encrypt(message_file, encryption_file)
    message = File.open(message_file, 'r')
    text = message.read
    message.close
    # remove key and date after testing
    encryption = Enigma.new.encrypt(text, '67929', '130621')
    file = File.open(encryption_file, 'w')
    file.write(encryption[:encryption])
    file.close
    "Created '#{File.basename(encryption_file)}' with the key #{encryption[:key]} and date #{encryption[:date]}"
  end

  def self.decrypt(encryption_file, decryption_file, key, date)
    encryption = File.open(encryption_file, 'r')
    ciphertext = encryption.read
    encryption.close
    decryption = Enigma.new.decrypt(ciphertext, key, date)
    file = File.open(decryption_file, 'w')
    file.write(decryption[:decryption])
    file.close
    "Created '#{File.basename(decryption_file)}' with the key #{decryption[:key]} and date #{decryption[:date]}"
  end

end
