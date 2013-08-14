class BowlingGame

  def initialize
    @score = 0
    @previous_roll = 0
    @spare = false
  end

  def roll(pins)
    handle_spare(pins)

    @spare = true if @previous_roll + pins == 10
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

end
