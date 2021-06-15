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
      encryption: encode_decode(message.to_s.downcase, key_gen.return_shifts, 1),
      key: key_gen.reveal,
      date: key_gen.date
    }
  end

  def decrypt(ciphertext, key=nil, date=Date.today)
    key_gen = KeyGen.new(key)
    key_gen.set_offsets(date)
    {
      decryption: encode_decode(ciphertext.to_s.downcase, key_gen.return_shifts, -1),
      key: key_gen.reveal,
      date: key_gen.date
    }
  end

  def encode_decode(message, shifts, positive_vs_negative_shift)
    output_arr = []
    message.split('').each_with_index do |char, index|
      if @alpha_arr.index(char) != nil
        total_shift = @alpha_arr.index(char) + ((shifts.values[index % shifts.values.length]) * positive_vs_negative_shift)
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
      decryption: encode_decode(ciphertext.to_s.downcase, key_gen.return_shifts, -1),
      date: key_gen.date,
      key: key_gen.reveal
    }
  end

  def reverse_shifts(ciphertext, date)
    decryption = ''
    cracked_key = '00001'
    until decryption[-4..-1] == ' end'
      key = KeyGen.new(cracked_key)
      key.set_offsets(date)
      decryption = encode_decode(ciphertext, key.return_shifts, -1)
      cracked_key = (cracked_key.to_i + 1).to_s
    end
    key.reveal
  end

end
