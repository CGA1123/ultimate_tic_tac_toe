class TicTacToe
  class MonteCarloPlayer
    attr_reader :root, :name

    def initialize(name: "monte_carlo", iterations: 1_000)
      @name = name
      @iterations = iterations
    end

    def play(state)
      set_root_node!(state)
      set_latest_node!(state)

      @iterations.times { MonteCarloTreeSearch.step(@latest) }

      @latest = MonteCarloTreeSearch.best(@latest)

      raise "bad move" unless state.available_moves.include?(@latest.transition)

      @latest.transition
    end

    def set_root_node!(state)
      return if defined?(@root)

      @root = Node.new(
        state: state,
        transition: nil,
        parent: nil
      )

      @latest = @root
    end

    def set_latest_node!(state)
      return if same_board?(@latest.state, state)

      @latest = @latest.children.find(-> { raise "No latest found" }) do |child|
        same_board?(child.state, state)
      end
    end

    def same_board?(a_game, b_game)
      a_game
        .board
        .zip(b_game.board)
        .all? { |a, b| a == b }
    end
  end
end
