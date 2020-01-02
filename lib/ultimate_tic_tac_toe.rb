require "ultimate_tic_tac_toe/version"

module UltimateTicTacToe
  class Error < StandardError; end

  autoload :Board, "ultimate_tic_tac_toe/board"
  autoload :UltimateBoard, "ultimate_tic_tac_toe/ultimate_board"
  autoload :Game, "ultimate_tic_tac_toe/game"
  autoload :GreedyPlayer, "ultimate_tic_tac_toe/greedy_player"
  autoload :RandomPlayer, "ultimate_tic_tac_toe/random_player"
  autoload :GrpcPlayer, "ultimate_tic_tac_toe/grpc_player"
  autoload :Protos, "ultimate_tic_tac_toe/protos/ultimate_tic_tac_toe_pb"
  autoload :Servers, "ultimate_tic_tac_toe/servers"

  module Protos
    autoload :PlayerService, "ultimate_tic_tac_toe/protos/ultimate_tic_tac_toe_services_pb"
  end

  class << self
    def start_server(handler, port)
      s = GRPC::RpcServer.new
      s.add_http2_port("0.0.0.0:#{port}", :this_port_is_insecure)
      s.handle(handler)
      s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
    end

    def build_grpc_game(address_one, address_two)
      player_x = GrpcPlayer.new(token: 'X', stub: Protos::PlayerService::Stub.new(address_one, :this_channel_is_insecure))
      player_o = GrpcPlayer.new(token: 'O', stub: Protos::PlayerService::Stub.new(address_two, :this_channel_is_insecure))

      Game.new(player_x: player_x, player_o: player_o, board_klass: UltimateBoard)
    end
  end
end
