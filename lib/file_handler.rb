require_relative 'enigma'

class FileHandler

  def self.retrieve_message
    message = $stdin.gets.chomp.downcase
  end

  def self.write_message(message_file)
    file = File.open(message_file, 'w')
    file.write(self.retrieve_message)
    file.close
  end

  def self.encrypt(message_file, encryption_file, key=nil, date=Date.today)
    self.write_message(message_file)
    message = File.open(message_file, 'r')
    text = message.read
    message.close
    encryption = Enigma.new.encrypt(text, key, date)
    file = File.open(encryption_file, 'w')
    file.write(encryption[:encryption])
    file.close
    "Created '#{File.basename(encryption_file)}' with the key #{encryption[:key]} and date #{encryption[:date]}"
  end

  def self.decrypt(encryption_file, decryption_file, key, date=Date.today)
    encryption = File.open(encryption_file, 'r')
    ciphertext = encryption.read
    encryption.close
    decryption = Enigma.new.decrypt(ciphertext, key, date)
    file = File.open(decryption_file, 'w')
    file.write(decryption[:decryption])
    file.close
    "Created '#{File.basename(decryption_file)}' with the key #{decryption[:key]} and date #{decryption[:date]}"
  end

  def self.crack(encryption_file, cracked_file, date=Date.today)
    encryption = File.open(encryption_file, 'r')
    ciphertext = encryption.read
    encryption.close
    cracked = Enigma.new.crack(ciphertext, date)
    file = File.open(cracked_file, 'w')
    file.write(cracked[:decryption])
    file.close
    "Created '#{File.basename(cracked_file)}' with the key #{cracked[:key]} and date #{cracked[:date]}"
  end

end
