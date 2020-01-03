# frozen_string_literal

module UltimateTicTacToe
  class UltimateBoard
    SIZE = 9
    WINS = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ]

    attr_reader :board

    def initialize(board = Array.new(SIZE) { Board.new }, last_move = nil)
      @board = board
      @last_move = last_move
    end

    def set(indices, value)
      big, small = indices

      new_board = @board[big].set(small, value)
      @board[big] = new_board

      self.class.new(@board, small)
    end

    def state
      return :win if winner
      return :draw if available_moves.empty?

      :running
    end

    def running?
      state == :running
    end

    def win?
      state == :win
    end

    def draw?
      state == :draw
    end

    def winner
      return @winner if defined?(@winner)

      @winner =
        WINS
          .map { |i, j, k| [@board[i], @board[j], @board[k]] }
          .select { |x| x.none?(&:running?) }
          .map { |x| x.map(&:winner).uniq }
          .find { |x| x.size == 1 && !x.first.nil? }
          &.first
    end

    def available_moves
      if @last_move.nil? || !@board[@last_move].running?
        @board
          .each_with_index
          .select { |board, i| board.running? }
          .map { |board, i| board.available_moves.map { |x| [i, x] } }
          .flatten(1)
      else
        @board[@last_move]
          .available_moves
          .map { |x| [@last_move, x] }
      end
    end
  end
end
