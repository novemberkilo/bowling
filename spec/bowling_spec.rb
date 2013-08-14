# 1. 10 frames
# 2. 10 pins
# 3. Each frame consists of 2 throws *
# 4. Spare
#     Frame 1: 7 3 # => 10 + 5: 15
#     Frame 2: 5 0 # => 15 + 5: 20
# 5. Strike
#     Frame 1: 10 # => 10 + 5 + 3: 18
#     Frame 2: 5 3 # => 18 + 5 + 3: 26

require File.expand_path("../../bowling", __FILE__)

describe Frame do

  it "knows if it is an open frame" do
    frame = Frame.new(2,4)
    frame.type.should == :open
    frame.first_roll.should   == 2
    frame.second_roll.should  == 4
  end

  it "knows if it is a spare frame" do
    frame = Frame.new(7,3)
    frame.type.should == :spare
    frame.first_roll.should   == 7
    frame.second_roll.should  == 3
  end

  it "knows if it is a strike frame" do
    frame = Frame.new(10, nil)
    frame.type.should == :strike
    frame.first_roll.should == 10
    frame.second_roll.should == nil
  end
end

describe BowlingGame do

  let(:game) { BowlingGame.new }

  it "scores 0 for a gutter ball game" do
    20.times { game.roll 0 }
    game.score.should == 0
  end

  it "scores as we expect for a simple game" do
    10.times { game.roll 2 }
    10.times { game.roll 1 }
    game.score.should == 30
  end

  it "scores a spare" do
    game.roll 7
    game.roll 3
    game.roll 5
    17.times { game.roll 0 }
    game.score.should == 20
  end

  it "scores a strike" do
    game.roll 10
    game.roll 5
    game.roll 3
    16.times { game.roll 0 }
    game.score.should == 26
  end

  it "scores a strike then a spare" do
    # first frame is open
    game.roll 5
    game.roll 0
    # next frame is a strike
    game.roll 10
    # next frame is a spare
    game.roll 7
    game.roll 3
    # next frame is open
    game.roll 2
    game.roll 3
    12.times { game.roll 0 }
    game.score.should == 42
  end

  it "scores a spare then a strike" do
    # first frame is open
    game.roll 5
    game.roll 0
    # next frame is a spare
    game.roll 7
    game.roll 3
    # next frame is a strike
    game.roll 10
    # next frame is open
    game.roll 2
    game.roll 3
    12.times { game.roll 0 }
    game.score.should == 45
  end

end
