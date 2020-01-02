# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: lib/ultimate_tic_tac_toe/protos/ultimate_tic_tac_toe.proto

require "google/protobuf"

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("lib/ultimate_tic_tac_toe/protos/ultimate_tic_tac_toe.proto", syntax: :proto3) do
    add_message "ultimate_tic_tac_toe.protos.Game" do
      repeated :available_moves, :message, 1, "ultimate_tic_tac_toe.protos.Move"
      repeated :game, :message, 2, "ultimate_tic_tac_toe.protos.Board"
      optional :state, :enum, 3, "ultimate_tic_tac_toe.protos.State"
      optional :player, :enum, 4, "ultimate_tic_tac_toe.protos.Player"
    end
    add_message "ultimate_tic_tac_toe.protos.Move" do
      optional :big_index, :int32, 1
      optional :small_index, :int32, 2
    end
    add_message "ultimate_tic_tac_toe.protos.Board" do
      repeated :cells, :enum, 1, "ultimate_tic_tac_toe.protos.Cell"
      optional :state, :enum, 2, "ultimate_tic_tac_toe.protos.State"
    end
    add_enum "ultimate_tic_tac_toe.protos.State" do
      value :RUNNING, 0
      value :WIN_O, 1
      value :WIN_X, 2
      value :DRAW, 3
    end
    add_enum "ultimate_tic_tac_toe.protos.Player" do
      value :PLAYER_X, 0
      value :PLAYER_O, 1
    end
    add_enum "ultimate_tic_tac_toe.protos.Cell" do
      value :CELL_X, 0
      value :CELL_O, 1
      value :EMPTY, 2
    end
  end
end

module UltimateTicTacToe
  module Protos
    Game = Google::Protobuf::DescriptorPool.generated_pool.lookup("ultimate_tic_tac_toe.protos.Game").msgclass
    Move = Google::Protobuf::DescriptorPool.generated_pool.lookup("ultimate_tic_tac_toe.protos.Move").msgclass
    Board = Google::Protobuf::DescriptorPool.generated_pool.lookup("ultimate_tic_tac_toe.protos.Board").msgclass
    State = Google::Protobuf::DescriptorPool.generated_pool.lookup("ultimate_tic_tac_toe.protos.State").enummodule
    Player = Google::Protobuf::DescriptorPool.generated_pool.lookup("ultimate_tic_tac_toe.protos.Player").enummodule
    Cell = Google::Protobuf::DescriptorPool.generated_pool.lookup("ultimate_tic_tac_toe.protos.Cell").enummodule
  end
end