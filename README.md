# Tic-Tac-Toe and Ultimate Tic-Tac-Toe

- `TicTacToe` implements a tic-tac-toe board
- `UltimateTicTacToe` implements an ultimate tic-tac-toe board

- Under both of these namespaces you can find a `Game` which takes two players and iterates through them.
- Each player is called in succession and asked to `#play(board)` (where board is the `TicTacToe` or `UltimateTicTacToe` instance) until the game reaches a terminal state.
- Implemented players are:
  - `RandomPlayer` selected a move at random from the boards `#available_moves`
  - `ConsolePlayer` selecting a move based on console input
  - `MonteCarloPlayer` selecting a move based on monte-carlo tree search


Running a game would look something like this:
```ruby
game = TicTacToe::Game.new(TicTacToe::RandomPlayer.new, TicTacToe::MonteCarloPlayer.new)
result = game.play

if result
  puts "#{result} won the game!"
else
  puts "game was a draw"
end
```

## gRPC

[gRPC](https://grpc.io/) support is implemented under the `Services` namespace
and wrap an exiting player to work over gRPC. In order to play a game with a
player over gRPC the `GrpcPlayer` class has been implemented.

For example, you may start a `RandomPlayer` served over gRPC and play against it.

In one process, run the `RandomPlayer` over gRPC:

```ruby
handler = TicTacToe::RandomPlayer.new               # The random player
service = Services::TicTacToe::Player.new(handler)  # Wrapped as a gRPC service

Services.start_service(service, 1123)               # Service on port 1123
```

And in another start the game:

```ruby
console_player = TicTacToe::ConsolePlayer.new
grpc_player = TicTacToe::GrpcPlayer.new('0.0.0.0:1123')
game = TicTacToe::Game.new(console_player, grpc_player)

game.play
```

The same can be done for `UltimateTicTacToe` by replacing it for all references to `TicTacToe` (`s/TicTacToe/UltimateTicTacToe/g`).

## Monte-Carlo Tree Search

This project implements a `MonteCarloPlayer` for `TicTacToe` and `UltimateTicTacToe`, which uses [Monte-Carlo Tree Search](https://en.wikipedia.org/wiki/Monte_Carlo_tree_search) to select its moves.

Monte-Carlo Tree Search is interesting because it doesn't require the implementation of any function to evaluate or score a game state directly, it instead uses random sampling to determine a score.

That is to say that given a particular game state, random simulations are run from that state and the result of these are back-progated up the tree. Over enough iteration we start to build confidence in the win-rate of sub-trees and can make pretty good decisions on which moves are the most optimal.

The implementation lives in the `MonteCarloTreeSearch` and `Node` classes.

A `FullTreeEvaluation` class is also implemented which will attempt to do a depth-first traversal of the full game tree. It can compute (on my machine) a full tree for tic-tac-toe in ~10 seconds, I haven't managed to get it to complete for ultimate tic-tac-toe, which is why using Monte-Carlo Tree Search is much better :smile:.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/CGA1123/ultimate_tic_tac_toe.

## License

The code is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
