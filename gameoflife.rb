class GameOfLife
  
  def initialize
    @size = 8
    @grid = [
      [0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0],
      [0,1,1,0,0,0,0,0],
      [0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0],
      [0,0,0,0,0,0,0,0],
    ]
    
    render
  end
  
  def tick
    sleep(3)
    next_tick = Array.new(@size) { Array.new(@size) }
    @grid.each_with_index do |line, row|
      line.each_with_index do |cell, column|
        next_tick[row][column] = cell_next_status(cell, row, column)
      end
    end
    @grid = next_tick
  end
  
  def cell_next_status(status, row, column)
    neighbours = [
      [-1, -1],
      [-1, 0],
      [-1, 1],
      [0, -1],
      [0, 1],
      [1, -1],
      [1, 0],
      [1, 1]
    ]
    neighbour_count = 0
    for item in neighbours
      begin
        if row + item[0] >= 0 and column + item[1] >= 0
          cell = @grid[row + item[0]][column + item[1]]
          if cell == 1
            neighbour_count += 1
          end
        end
      rescue
      end 
    end
    
    result = 0
    if status = 1
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
    print "\e[2J\e[f"
    for line in @grid
      puts line.join " "
    end
    puts "-----"
  end
  
end

game = GameOfLife.new
loop do
  game.tick
  game.render
end