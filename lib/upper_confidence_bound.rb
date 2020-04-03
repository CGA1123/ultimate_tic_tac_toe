# Implements the UCT (Upper Confidence Bound 1 applied to trees) function
module UpperConfidenceBound
  class << self
    C_VALUE = Math.sqrt(2)

    def value(node)
      return Float::INFINITY if node.visits.zero?

      exploitation = node.wins / node.visits
      exploration = C_VALUE * Math.sqrt(
        Math.log(node.parent.visits) / node.visits
      )

      exploitation + exploration
    end
  end
end
