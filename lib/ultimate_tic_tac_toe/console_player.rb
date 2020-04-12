class UltimateTicTacToe
  class ConsolePlayer
    attr_reader :name

    def initialize(name = "console", printer = Printer.new)
      @name = name
      @printer = printer
    end

    def play(board)
      @printer.print_board(board)

      get_move(board)
    end

    private

    def get_move(board)
      move = nil
      available = board.available_moves

      available
        .map
        .with_index { |m, i| "#{i}: #{m.inspect}" }
        .each { |x| puts x }

      while move.nil?
        puts "Choose a move:"
        print "> "
        m = gets.chomp

        if m =~ /\d+/ && (available.size > m.to_i)
          move = m.to_i
        end
      end

      available[move]
    end
  end
end
