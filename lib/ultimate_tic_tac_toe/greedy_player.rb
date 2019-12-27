module UltimateTicTacToe
  class GreedyPlayer
    def initialize(token)
      @token = token
    end

    def play(board)
      move = board.available_moves.first
      board.set(move, @token)
    end
  end
end
