class BowlingGame

  def initialize
    @score = 0
    @previous_roll = 0
    @spare = false
    @strike = false
  end

  def roll(pins)
    adjust_score_for_strike_or_spare(pins)

    @strike = is_it_a_strike?(pins)
    @spare  = is_it_a_spare?(pins)

    @score += pins
    @previous_roll = pins
  end

  def score
    @score
  end

  private

  def is_it_a_strike?(pins)
    pins == 10 ? true : @strike
  end

  def is_it_a_spare?(pins)
    !@strike && (@previous_roll + pins == 10)
  end

  def adjust_score_for_strike_or_spare(pins)
    handle_spare(pins)
    handle_strike(pins)
  end

  def handle_spare(pins)
    return unless @spare
    @score += pins
    @spare = false
  end

  def handle_strike(pins)
    return unless @strike
    return if @previous_roll == 10
    @score += pins + @previous_roll
    @strike = false
  end

end
