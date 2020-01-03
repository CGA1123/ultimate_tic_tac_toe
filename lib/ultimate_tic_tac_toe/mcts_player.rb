require 'mcts'

module UltimateTicTacToe
  class MctsPlayer
    def initialize(token)
      @token = token
    end

    def play(board)
      # TODO: don't throw away calculations during the game,
      # find the new 'root' based on the new board.
      root = Mcts::Node.root(board: board, player: @token)

      1000.times { root.choose_child }

      best = root.best_move

      board.set(best, @token)
    end
  end
end
