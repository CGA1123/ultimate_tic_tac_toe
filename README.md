# UltimateTicTacToe

An Ultimate Tic-Tac-Toe server implementation. Players are expected to be implemented over gRPC, the protocol can be seen under `lib/protos`.

## Usage

- Implement a valid `UltimateTicTacToe::Protos::PlayerService::Service` (or in any other language gRPC supports!)
- Start a game via `UltimateTicTacToe.build_grpc_game(player_one_address, player_two_address).play`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/CGA1123/ultimate_tic_tac_toe.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
