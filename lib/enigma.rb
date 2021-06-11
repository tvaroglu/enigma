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
      encryption: encode_decode(message, key_gen.return_shifts),
      key: key_gen.reveal,
      date: key_gen.date
    }
  end

  def encode_decode(message, shifts)
    # example formula:
    #12+75-(27*3)
    # 1. position in alpha (starting at 1)
    # 2. PLUS total shift
    # 3. MINUS (27* X)  (until back in range 1..27)
    #return letter from position found in step3
  end

end
