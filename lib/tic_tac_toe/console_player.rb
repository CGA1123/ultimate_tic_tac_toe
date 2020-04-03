class TicTacToe
  class ConsolePlayer
    attr_reader :name

    def initialize(name = "console", printer = Printer.new)
      @name = name
      @printer = printer
    end

    def name
      "console"
    end

    def play(board)
      @printer.print_board(board)

      move = get_move(board)
    end

    def get_move(board)
      move = nil
      available = board.available_moves

      while move.nil?
        puts "Choose a move: #{available.map { |x| x + 1 }.inspect}"
        print "> "
        m = gets.chomp

        if m =~ /\d/ && available.include?(m.to_i - 1)
          move = m.to_i - 1
        end
      end

      move
    end
  end
end
