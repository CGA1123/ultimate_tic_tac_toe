class UltimateTicTacToe
  class MonteCarloPlayer
    attr_reader :root, :name

    def initialize(name: "monte_carlo", iterations: 1_000)
      @name = name
      @iterations = iterations
    end

    def play(state)
      set_root!(state)
      set_latest!(state)

      @iterations.times { MonteCarloTreeSearch.step(@latest) }

      @latest = MonteCarloTreeSearch.best(@latest)

      raise "bad move" unless state.available_moves.include?(@latest.transition)

      @latest.transition
    end

    private

    def set_root!(state)
      return @root if defined?(@root)

      @root = Node.new(
        state: state,
        transition: nil,
        parent: nil
      )

      @latest = @root
    end

    def set_latest!(state)
      return if same_board?(@latest.state, state) && same_available_moves?(@latest.state, state)

      @latest = @latest.children.find(-> { raise "No latest found" }) { |child|
        same_board?(child.state, state) && same_available_moves?(child.state, state)
      }
    end

    def same_available_moves?(a, b)
      a.available_moves == b.available_moves
    end

    def same_board?(a_game, b_game)
      a_game
        .board
        .zip(b_game.board)
        .all? { |a, b| a == b }
    end
  end
end
