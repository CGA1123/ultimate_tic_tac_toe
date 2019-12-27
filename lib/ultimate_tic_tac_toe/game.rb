module UltimateTicTacToe
  class Game
    def initialize(player_x:, player_o:, board_klass: Board)
      @players = [player_x, player_o].cycle
      @board_klass = board_klass
      @board = @board_klass.new
    end

    def play
      while !@board.draw? && !@board.win?
        @board = @players.next.play(@board)
      end

      @board.winner
    end

    def reset!
      @board = @board_klass.new
    end
  end
end
