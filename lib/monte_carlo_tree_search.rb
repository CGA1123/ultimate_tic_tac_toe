class MonteCarloTreeSearch
  class << self
    def best(node)
      node.children.max_by(&:visits)
    end

    def step(node)
      # 1. Selection
      #
      # Select a node to explore by walking down the tree until we hit a leaf at
      # each level, select the node with the highest UCT value.
      node_to_explore = node

      while !node_to_explore.children.empty?
        node_to_explore =
          node_to_explore
            .children
            .max_by { |c| UpperConfidenceBound.value(c) }
      end

      # 2. Expansion
      #
      # Choose a node to simulate on based on the selected node to explore.
      # If the selected node to explore is in a terminal state choose it.
      # Else, expand that node to contain all its possible children and select a
      # random on to simulate on
      node_to_simulate =
        if node_to_explore.final?
          node_to_explore
        else
          node_to_explore.expand!
          node_to_explore.children.sample
        end

      # 3. Simulation
      #
      # Randomly play through a game until reaching a terminal state.
      # Return 1 if it results in a win for the selected nodes player
      # Return -1 if it results in a loss for the selected nodes player
      # Return 0 if it results in a draw
      simulation_result = node_to_simulate.simulate

      # 4. Backpropagation
      #
      # Update the current node, incrementing the visit counter and the win counter
      # Increment win counter by 1 on win and by 0.5 on draw.
      #
      # Recurse up the tree until reaching the root node.
      back_propagate(simulation_result, node_to_simulate)
    end

    def back_propagate(result, node)
      current_node = node
      current_result = result

      while !current_node.nil?
        current_node.visits += 1

        case current_result
        when 1 then current_node.wins += 1
        when 0 then current_node.wins += 0.5
        end

        current_result = current_result * -1
        current_node = current_node.parent
      end
    end
  end
end
