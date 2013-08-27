class BowlingGame

  def initialize
    @score = 0
    @previous_roll = nil
    @frames = []
  end

  def roll(pins)
    return if its_a_strike?(pins)
    return if its_the_end_of_a_frame?(pins)
    @previous_roll = pins
  end

  def score
    raise StandardError, "Too many frames" if @frames.count > 10
    @frames.each_with_index do |f, i|
      @score += f.score(@frames[i+1])
    end
    @score
  end

  private

  def its_a_strike?(pins)
    return false unless pins == 10
    @frames << Strike.new(10, nil)
    @previous_roll = nil
    true
  end

  def its_the_end_of_a_frame?(pins)
    return false unless @previous_roll
    klass = (pins + @previous_roll == 10) ? Spare : Frame
    @frames << klass.new(@previous_roll, pins)
    @previous_roll = nil
    true
  end

end

class Frame

  attr_reader :first_roll, :second_roll

  def initialize(first_roll, second_roll)
    @first_roll = first_roll
    @second_roll = second_roll
  end

  def score(next_frame=nil)
    first_roll + second_roll
  end

end

class Spare < Frame
  def score(next_frame)
    10 + next_frame.first_roll
  end
end

class Strike < Frame
  def score(next_frame)
    10 + next_frame.first_roll + next_frame.second_roll
  end
end
