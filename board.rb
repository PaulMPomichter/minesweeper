class Board
  def initialize
    @grid = Array.new(9) { Array.new(9) }
  end

  def seed
    @grid.each_with_index do |row, i1|
      row.map!.with_index do |tile, i2|
        random = rand(10)
        pos = [i1, i2]

        case random
        when 0
          Tile.new(pos, true, self)
        when 1..9
          Tile.new(pos, false, self)
        end
      end
    end
  end

  def render
    @grid.each do |row|
      p row.map(&:state)
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def place_flag(pos)
    self[pos].flag = true
  end
end