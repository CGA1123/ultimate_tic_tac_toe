class Node
  attr_accessor :visits, :wins
  attr_reader :state, :transition, :children, :parent

  def initialize(state:, transition:, parent:, visits: 0.0, wins: 0.0, children: [])
    @state = state
    @visits = visits
    @wins = wins
    @transition = transition
    @parent = parent
    @children = []
  end

  def expand!
    return if @explored

    @children = all_children

    @explored = true
  end

  def final?
    !@state.running?
  end

  def all_children
    @all_children ||= @state.available_moves.map do |transition|
      self.class.new(
        state: @state.play(transition),
        transition: transition,
        parent: self
      )
    end
  end

  def simulate
    current = @state

    while current.running?
      current = current.play(
        current.available_moves.sample
      )
    end

    if current.draw?
      0
    else
      current.winner == @state.player ? 1 : -1
    end
  end
end
