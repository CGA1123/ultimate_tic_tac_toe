class TicTacToe
  class RandomPlayer
    attr_reader :name

    def initialize(name = "random")
      @name = name
    end

    def play(game)
      game.available_moves.sample
    end
  end
end
