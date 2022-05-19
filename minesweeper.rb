require_relative "./board.rb"
require_relative "./tile.rb"

class Minesweeper
  attr_reader :board

  def initialize
    @board = Board.new
  end
end

if __FILE__ == $PROGRAM_NAME
  game = Minesweeper.new
  game.board.seed
  #testing
  game.board.place_flag([0, 0])
  game.board.render
end