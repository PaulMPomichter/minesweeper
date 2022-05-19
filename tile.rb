class Tile
  attr_accessor :bomb, :revealed, :flag
  attr_reader :pos

  # Note: alias_method will only provide the getter, the setter will remain the same

  alias_method :bomb?, :bomb
  alias_method :revealed?, :revealed
  alias_method :flag?, :flag

  def initialize(pos, bomb, board)
    @pos, @bomb, @board = pos, bomb, board
    @revealed = false
    @flag = false
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
      "_"
    end

    result
  end
end