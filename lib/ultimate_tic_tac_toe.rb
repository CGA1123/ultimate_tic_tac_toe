require "ultimate_tic_tac_toe/version"

module UltimateTicTacToe
  class Error < StandardError; end

  autoload :Board, "ultimate_tic_tac_toe/board"
  autoload :UltimateBoard, "ultimate_tic_tac_toe/ultimate_board"
  autoload :Game, "ultimate_tic_tac_toe/game"
  autoload :GreedyPlayer, "ultimate_tic_tac_toe/greedy_player"
  autoload :RandomPlayer, "ultimate_tic_tac_toe/random_player"
  autoload :Protos, "ultimate_tic_tac_toe/protos/ultimate_tic_tac_toe_pb"

  module Protos
    autoload :PlayerService, "ultimate_tic_tac_toe/protos/ultimate_tic_tac_toe_services_pb"
  end
end
