class GameOfLife
  
  attr_accessor :grid
  
  def initialize(grid, size)
    @size = size
    @grid = grid
  end
  
  def tick
    sleep(1)
    next_tick = Array.new(@size) { Array.new(@size) }
    @grid.each_with_index do |line, row|
      line.each_with_index do |cell, column|
        next_tick[row][column] = cell_next_status(cell, row, column)
      end
    end
    if @grid == next_tick
      abort("No change")
    else
      @grid = next_tick
    end
  end
  
  def alive_neighbours(row, column)
    neighbours = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1], [0, 1],
      [1, -1], [1, 0], [1, 1]
    ]
    neighbour_count = 0
    for item in neighbours
      if (row + item[0] >= 0) and (column + item[1] >= 0)
        if @grid[row + item[0]] and @grid[row + item[0]][column + item[1]] == 1
          neighbour_count += 1
        end
      end
    end
    neighbour_count
  end
  
  def cell_next_status(status, row, column)
    neighbour_count = alive_neighbours(row, column)
    result = 0
    if status == 1
      if neighbour_count == 2 or neighbour_count == 3
        result = 1  
      end
    else
      if neighbour_count == 3
        result = 1
      end
    end
    result
  end
  
  def render
    for line in @grid
      puts line.join " "
    end
    puts "-" * @size * 2
  end
  
end

if __FILE__ == $0
  grid = [
    [0,0,0,0,0],
    [0,1,0,0,0],
    [0,1,0,1,0],
    [0,1,1,0,0],
    [0,0,0,0,0],
  ]
  game = GameOfLife.new(grid, 5)
  loop do
    game.render
    game.tick
  end
end