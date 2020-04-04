class UltimateTicTacToe
  class Printer
    def initialize(printer = ->(x) { puts x })
      @printer = printer
    end

    def print_board(game)
      tokens = game.board.map { |b| local_board(b) }
      lines = (0..8).map { |i|
        offset = (i / 3) * 3
        modulo = i % 3

        tokens[offset][modulo] + tokens[offset + 1][modulo] + tokens[offset + 2][modulo]
      }

      pretty =
        lines
          .map { |line| line.each_slice(3).reduce { |acc, x| acc + ["||"] + x } }
          .each_slice(3).reduce { |acc, x| acc + [["="] * 13] + x }

      pretty.map do |line|
        @printer.call line.join(" ")
      end
    end

    private

    def local_board(board)
      if board.is_a?(Array)
        board.each_slice(3).map do |slice|
          slice.map { |x| token(x) }
        end
      else
        [
          [" ", " ", " "],
          [" ", token(board), " "],
          [" ", " ", " "]
        ]
      end
    end

    def token(x)
      case x
      when UltimateTicTacToe::EMPTY then "-"
      when UltimateTicTacToe::PLAYER_O then "O"
      when UltimateTicTacToe::PLAYER_X then "X"
      else
        "?"
      end
    end
  end
end
