class BowlingGame

  def initialize
    @score = 0
    @previous_roll = 0
    @spare = false
    @strike = false
  end

  def roll(pins)
    handle_spare(pins)
    handle_strike(pins)

    @strike = true if pins == 10
    @spare = true if !@strike && (@previous_roll + pins == 10)
    @score += pins
    @previous_roll = pins
  end

  def score
    @score
  end

  private

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
