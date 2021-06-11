class KeyGen
  attr_reader :key

  def initialize
    @key = Array.new
    @key << rand(0..9).to_s until @key.length == 5
    @key = @key.join
  end

end
