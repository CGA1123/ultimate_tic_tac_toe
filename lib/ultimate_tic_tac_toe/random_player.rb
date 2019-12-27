module UltimateTicTacToe
  class RandomPlayer
    def initialize(token)
      @token = token
    end

    def play(board)
      move = board.available_moves.sample
      board.set(move, @token)
    end
  end
end
