require "test/unit"
require "./gameoflife.rb"
 
class GameOfLifeTest < Test::Unit::TestCase
 
  def a_single_cell_should_die
    grid = [
      [0,0,0],
      [0,1,0],
      [0,0,0]
    ]
    expected = [
      [0,0,0],
      [0,0,0],
      [0,0,0]
    ]
    game = GameOfLife.new(grid, 3)
    game.tick
    assert_equal(expected, game.grid)
  end
 
end