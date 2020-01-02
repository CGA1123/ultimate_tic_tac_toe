# frozen_string_literal

module UltimateTicTacToe
  class Board
    SIZE = 9
    EMPTY = Object.new
    EMPTY_BOARD = Array.new(SIZE) { EMPTY }
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

    def initialize(board = EMPTY_BOARD)
      @board = board
    end

    def set(index, value)
      board = @board.dup
      board[index] = value

      board.freeze

      self.class.new(board)
    end

    def state
      @state ||= calculate_state
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
          .map { |i, j, k| [@board[i], @board[j], @board[k]].uniq }
          .find { |x| x.size == 1 && x.first != EMPTY }
          &.first
    end

    def available_moves
      @available_moves ||=
        @board
          .each_with_index
          .map { |value, i| value == EMPTY ? i : nil }
          .compact
    end

    private

    def calculate_state
      return :win if winner
      return :draw if available_moves.empty?

      :running
    end
  end
end
