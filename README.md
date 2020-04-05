# Monte-Carlo Tree Search for Tic-Tac-Toe and Ultimate Tic-Tac-Toe

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

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/CGA1123/ultimate_tic_tac_toe.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
