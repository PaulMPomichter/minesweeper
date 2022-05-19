require "yaml"
require_relative "./board.rb"
require_relative "./tile.rb"

class Minesweeper
  attr_reader :board

  def initialize
    @board = Board.new
    @board.seed
  end

  def get_pos
    puts "Please enter a position (like 1,2)"
    print ">"

    pos = self.parse_pos(gets.chomp)
  end

  def parse_pos(pos)
    pos.split(",").map(&:to_i)
  end

  def get_action
    puts "Please enter f for flag, or r for reveal"
    print ">"

    action = self.parse_action(gets.chomp)
  end

  def parse_action(action)
    action.downcase
  end

  def play_turn
    system("clear")
    puts "Game Autosaved"
    puts
    self.save_game
    @board.render

    pos = self.get_pos
    action = self.get_action

    if action == "f"
      @board.place_flag(pos)
    elsif action == "r"
      @board.reveal(pos)
    end
  end

  def run
    self.play_turn until @board.over?

    if @board.win?
      puts "You win!"
      @board.render
    elsif @board.lose?
      puts "BOOM!"
    end
  end

  def save_game
    File.write("save.yml", YAML.dump(self))
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Load game? (y/n)"
  print ">"
  load_game = gets.chomp

  case load_game
  when "y"
    YAML.unsafe_load(File.open("save.yml")).run
  when "n"
    Minesweeper.new.run
  end
end