class UltimateTicTacToe
  class MonteCarloPlayer
    attr_reader :root, :name

    def initialize(name: "monte_carlo", iterations: 1_000)
      @name = name
      @iterations = iterations
    end

    def play(state)
      @root = Node.new(
        state: state,
        transition: nil,
        parent: nil
      )

      @iterations.times { MonteCarloTreeSearch.step(@root) }

      best = MonteCarloTreeSearch.best(@root)

      raise "bad_move" unless state.available_moves.include?(best.transition)

      best.transition
    end
  end
end
