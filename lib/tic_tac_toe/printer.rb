class TicTacToe
  class Printer
    def initialize(printer = ->(x) { puts x })
      @printer = printer
    end

    def print_board(game)
      tokens = game.board.map.with_index { |token, index|
        if token == game.class::EMPTY
          index + 1
        elsif token == game.class::PLAYER_X
          "X"
        elsif token == game.class::PLAYER_O
          "O"
        else
          "?"
        end
      }

      @printer.call <<~BOARD
        -------------
        | #{tokens[0]} | #{tokens[1]} | #{tokens[2]} |
        |---+---+---|
        | #{tokens[3]} | #{tokens[4]} | #{tokens[5]} |
        |---+---+---|
        | #{tokens[6]} | #{tokens[7]} | #{tokens[8]} |
        -------------
      BOARD
    end
  end
end
