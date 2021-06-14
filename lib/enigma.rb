require_relative 'key_gen'

class Enigma
  attr_reader :alpha_arr

  def initialize
    @alpha_arr = ('a'..'z').to_a << ' '
  end

  def encrypt(message, key=nil, date=Date.today)
    key_gen = KeyGen.new(key)
    key_gen.set_offsets(date)
    {
      encryption: encode(message.to_s.downcase, key_gen.return_shifts),
      key: key_gen.reveal,
      date: key_gen.date
    }
  end

  def encode(message, shifts)
    output_arr = []
    message.split('').each_with_index do |char, index|
      if @alpha_arr.index(char) != nil
        total_shift = @alpha_arr.index(char) + shifts.values[index % shifts.values.length]
        new_position = total_shift - (@alpha_arr.length * (total_shift.to_f / @alpha_arr.length).floor)
        output_arr << @alpha_arr[new_position]
      else
        output_arr << char
      end
    end
    output_arr.join
  end

  def decrypt(ciphertext, key=nil, date=Date.today)
    key_gen = KeyGen.new(key)
    key_gen.set_offsets(date)
    {
      decryption: decode(ciphertext.to_s.downcase, key_gen.return_shifts),
      key: key_gen.reveal,
      date: key_gen.date
    }
  end

  def decode(ciphertext, shifts)
    output_arr = []
    ciphertext.split('').each_with_index do |char, index|
      if @alpha_arr.index(char) != nil
        total_shift = @alpha_arr.index(char) - shifts.values[index % shifts.values.length]
        new_position = total_shift - (@alpha_arr.length * (total_shift.to_f / @alpha_arr.length).floor)
        output_arr << @alpha_arr[new_position]
      else
        output_arr << char
      end
    end
    output_arr.join
  end

  def crack(ciphertext, date=Date.today)
    cracked = reverse_shifts(ciphertext.to_s.downcase, date)
    key_gen = KeyGen.new(cracked)
    key_gen.set_offsets(date)
    {
      decryption: decode(ciphertext.to_s.downcase, key_gen.return_shifts),
      date: key_gen.date,
      key: key_gen.reveal
    }
  end

  def reverse_shifts(ciphertext, date)
    decryption = ''
    until decryption[-4..-1] == ' end'
      key = KeyGen.new
      key.set_offsets(date)
      decryption = decode(ciphertext, key.return_shifts)
    end
    key.reveal
  end

end
