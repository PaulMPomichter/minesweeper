class Tile
  attr_accessor :bomb, :revealed, :flag
  attr_reader :pos

  # Note: alias_method will only provide the getter, the setter will remain the same

  alias_method :bomb?, :bomb
  alias_method :revealed?, :revealed
  alias_method :flag?, :flag

  def initialize(pos, bomb)
    @pos, @bomb = pos, bomb
    @revealed = false
    @flag = false
    @neighbors = []
  end

  def populate_neighbors(board)
    neighbor_positions = self.find_neighbors(board)

    neighbor_positions.each do |np|
      @neighbors << board[np]
    end
  end

  def neighbor_bombs
    @neighbors.count { |tile| tile.bomb? }
  end

  def inspect
    { :pos => @pos, :bomb? => @bomb, :flag? => @flag }.inspect
  end

  def state
    result = if !@revealed
      if @flag
        "F"
      else
        "*"
      end
    else
      self.neighbor_bombs.to_s
    end

    result
  end

  def find_neighbors(board)
    deltas = [
      [-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]
    ]
    neighbor_pos = []

    deltas.each do |delta|
      neighbor_pos << @pos.map.with_index do |e, i|
        e + delta[i]
      end
    end

    neighbor_pos.select do |arr|
      arr.all? { |e| e >= 0 && e < board.grid.length && e < board.grid[0].length }
    end
  end
end