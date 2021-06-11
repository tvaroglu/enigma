class KeyGen
  attr_reader :key

  def initialize
    @key = Array.new
    @key << rand(0..9).to_s until @key.length == 5
    @key = @key.join
  end

  def reduce_date(date=Date.today)
    unless date.class == String && date.length == 6
      date = Date.parse(date.to_s)
      date = date.strftime("%d") + date.strftime("%m") + date.strftime("%y")
    end
    (date.to_i**2).to_s[-4..-1]
  end

  def return_offsets
    split = @key.split('')
    require "pry"; binding.pry
    reduce_date
  end

end
