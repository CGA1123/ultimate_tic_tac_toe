class TicTacToe
  class Game
    def initialize(player_one, player_two, printer: Printer.new)
      @board = TicTacToe.empty_board
      @players = [player_one, player_two].shuffle.cycle
      @printer = printer
    end

    def play
      while @board.running?
        @board = @board.play(@players.next.play(@board))
      end

      @printer.print_board(@board)

      @players.next
      @players.next.name if @board.win?
    end
  end
end
