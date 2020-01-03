module Mcts
  class Node
    attr_accessor :hits, :misses, :total_trials
    attr_reader :board, :player, :parent, :move

    def self.root(board:, player:)
      new(board: board, player: player, parent: nil, move: nil)
    end

    def initialize(board:, parent:, player:, move:)
      @board = board
      @player = player
      @parent = parent
      @move = move
      @hits = 0
      @misses = 0
      @total_trials = 0
    end

    def best_move
      children.max_by { |c| c.total_trials }.move
    end

    def choose_child
      run if children.empty?

      unexplored = children.select { |child| child.total_trials.zero? }

      if unexplored.empty?
        children.max_by { |child| child.potential(self) }.run
      else
        unexplored.sample.run
      end
    end

    def run
      back_propagate(simulate)
    end

    def children
      @children ||= board.available_moves.map do |move|
        self.class.new(
          board: board.set(move, player),
          move: move,
          player: player == 'X' ? 'O' : 'X',
          parent: self
        )
      end
    end

    def simulate
      tmp_board = board
      tmp_player = player

      while tmp_board.running?
        random_move = tmp_board.available_moves.sample
        tmp_board = tmp_board.set(random_move, tmp_player)
        tmp_player = tmp_player == 'X' ? 'O' : 'X'
      end

      tmp_board.winner == player ? 1 : 0
    end

    def back_propagate(simulation)
      if simulation > 0
        @hits += 1
      elsif simulation < 0
        @misses += 1
      end

      @total_trials += 1

      parent.back_propagate(-simulation) if parent
    end

    def potential(parent)
      w = misses - hits
      n = total_trials
      c = Math.sqrt(2)
      t = parent.total_trials

      (w / n) + (c * Math.sqrt(Math.log(t) * n))
    end
  end
end
