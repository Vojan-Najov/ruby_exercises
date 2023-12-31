class Sequence
  include Enumerable

  def initialize(from, to, by)
    @from, @to, @by = from, to, by
  end

  def each
    x = @from
    while x <= @to
      yield x
      x += @by
    end
  end

  def length
    return 0 if @from > @to

    Integer((@to - @from) / @by) + 1
  end

  alias size length

  def [](index)
    return nil if index < 0

    v = @from + index * @by
    if v <= @to
      return v
    else
      return nil
    end
  end

  def *(factor)
    return Sequence.new(@from * factor, @to * factor, @by * factor)
  end

  def +(offset)
    return Sequence.new(@from + offset, @to + offset, @by + offset)
  end
end

s = Sequence.new(1, 10, 2)
s.each { |x| print x }
puts
puts s[s.size - 1]
t = (s + 1) * 2

module Sequences
  def self.fromtoby(from, to, by)
    x = from
    while x <= to
      yield x
      x += by
    end
  end
end

Sequences.fromtoby(1, 10, 2) { |x| print x }
puts

class Range
  def by(step)
    x = self.begin
    if exclude_end?
      while x < self.end
        yield x
        x += step
      end
    else
      while x <= self.end
        yield x
        x +=step
      end
    end
  end
end

(0..10).by(2) { |x| print x }
puts
(0...10).by(2) { |x| print x }
puts

