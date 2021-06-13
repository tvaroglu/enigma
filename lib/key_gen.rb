require 'date'

class KeyGen
  attr_reader :date

  def initialize(key=nil)
    unless key.class == String && key.length == 5 && !(
      key.to_s.split('').all? { |char| char.to_i == 0 })
      @key = Array.new
      @key << rand(0..9).to_s until @key.length == 5
      @key = @key.join
    else
      @key = key
    end
    @date = Date.parse((Date.today).to_s).strftime('%d%m%y')
  end

  def reveal
    @key
  end

  def set_offsets(date=Date.today)
    if date.class == String && date.length == 6 && !(
      date.to_s.split('').all? { |char| char.to_i == 0 })
      @date = date
    end
    (@date.to_i**2).to_s[-4..-1]
  end

  def return_shifts
    keys = @key.split('')
    offsets = set_offsets(@date).split('')
    shifts = {
      :a => keys[0..1].join.to_i + offsets[0].to_i,
      :b => keys[1..2].join.to_i + offsets[1].to_i,
      :c => keys[2..3].join.to_i + offsets[2].to_i,
      :d => keys[3..4].join.to_i + offsets[3].to_i
    }
  end

end
