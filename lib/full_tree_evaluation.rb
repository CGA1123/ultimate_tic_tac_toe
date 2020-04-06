# Does a lazy depth first traversal of the game tree back propagating results
# when hitting a leaf node / terminal game state.
class FullTreeEvaluation
  def initialize(root)
    @root = root
  end

  def traverse!
    return if @traversed

    traverse(@root)

    @traversed = true
  end

  private

  def traverse(node)
    if node.final?
      result = node.state.draw? ? 0 : -1

      backpropagate(result, node)
    else
      node.expand!

      node.children.each { |child| traverse(child) }
    end
  end

  def backpropagate(result, node)
    current_node = node
    current_result = result

    until current_node.nil?
      current_node.visits += 1

      case current_result
      when 1 then current_node.wins += 1
      when 0 then current_node.wins += 0.5
      end

      current_result *= -1
      current_node = current_node.parent
    end
  end
end
