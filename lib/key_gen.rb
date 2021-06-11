class KeyGen

  def initialize
    @key = Array.new
    @key << rand(0..9).to_s until @key.length == 5
    @key = @key.join
    @offsets = ''
  end

  def reveal
    [@key, @offsets]
  end

  def return_offsets(date=Date.today)
    unless date.class == String && date.length == 6 && !(date.to_s.split('').all? { |char| char.to_i == 0 })
      date = Date.parse((Date.today).to_s)
      date = date.strftime("%d") + date.strftime("%m") + date.strftime("%y")
    end
    @offsets = (date.to_i**2).to_s[-4..-1]
  end

  def return_shifts
    keys = @key.split('')
    offsets = @offsets.split('')
    shifts = {
      :a => keys[0..1].join.to_i + offsets[0].to_i,
      :b => keys[1..2].join.to_i + offsets[1].to_i,
      :c => keys[2..3].join.to_i + offsets[2].to_i,
      :d => keys[3..4].join.to_i + offsets[3].to_i
    }
  end

end
