class UltimateTicTacToe
  class RandomPlayer
    attr_reader :name

    def initialize(name = "random")
      @name = name
    end

    def play(board)
      board.available_moves.sample
    end
  end
end
