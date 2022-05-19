class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(9) { Array.new(9) }
  end

  def seed
    @grid.each_with_index do |row, i1|
      row.map!.with_index do |tile, i2|
        random = rand(20)
        pos = [i1, i2]

        case random
        when 0..3
          Tile.new(pos, true)
        when 4..19
          Tile.new(pos, false)
        end
      end
    end

    @grid.flatten.each { |tile| tile.populate_neighbors(self) }
  end

  def render
    puts "  #{(0..8).to_a.join(" ")}".colorize(:color => :green)
    grid.each_with_index do |row, i|
      puts "#{i.to_s.colorize(:color => :green)} #{row.map(&:state).join(" ").colorize(:background => :light_yellow)}"
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def place_flag(pos)
    self[pos].flag = true
  end

  def reveal(pos)
    self[pos].revealed = true
    #stop revealing if we landed on a tile with adjacent bombs to create the "number fringe"
    return nil if self[pos].neighbor_bombs > 0
    #iterate through neighbors and reveal all empties and the fringe
    self[pos].neighbors.each do |tile|
      if !tile.bomb? && !tile.revealed? && tile.neighbor_bombs > 0
        tile.revealed = true #if numbered fringe, just reveal it
      elsif !tile.bomb? && !tile.revealed? && tile.neighbor_bombs == 0
        self.reveal(tile.pos) #if empty, recursive call
      end
    end
  end

  def lose?
    @grid.flatten.any? { |tile| tile.bomb? && tile.revealed? }
  end

  def win?
    flat = @grid.flatten
    bombs = flat.count { |tile| tile.bomb? }
    uncovered = flat.count { |tile| tile.revealed? }
    flat.length - uncovered == bombs
  end

  def over?
    self.win? || self.lose?
  end
end