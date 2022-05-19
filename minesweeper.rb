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
  game.board.render
end