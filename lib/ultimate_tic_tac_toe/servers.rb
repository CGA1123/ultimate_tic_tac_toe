module UltimateTicTacToe
  module Servers
    class Random < Protos::PlayerService::Service
      def play(game, _)
        move = game.available_moves.sample

        puts "Playing: #{move.big_index}, #{move.small_index} - #{game.player}"

        move
      end
    end

    class Greedy < Protos::PlayerService::Service
      def play(game, _)
        game.available_moves.first
      end
    end
  end
end
