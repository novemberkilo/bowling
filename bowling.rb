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
      @score += case f.type
                when :open
                  f.first_roll + f.second_roll
                when :spare
                  10 + @frames[i+1].first_roll
                when :strike
                  10 + @frames[i+1].first_roll + @frames[i+1].second_roll
                else
                  raise StandardError, "Unkown frame type"
                end
    end
    @score
  end

  private

  def its_a_strike?(pins)
    return false unless pins == 10
    @frames << Frame.new(10, nil)
    @previous_roll = nil
    true
  end

  def its_the_end_of_a_frame?(pins)
    return false unless @previous_roll
    @frames << Frame.new(@previous_roll, pins)
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

  def type
    return :strike if first_roll == 10
    return :spare if first_roll + second_roll == 10
    :open
  end

end

