module Services
  module TicTacToe
    class Player < ProtocolBuffers::TicTacToe::PlayerService::Service
      class << self
        def decode_game(game)
          ::TicTacToe.new(
            player: decode_player(game.player),
            board: game.board.map { |cell| decode_player(cell) }
          )
        end

        def encode_move(move)
          ProtocolBuffers::TicTacToe::Move.new(
            index: move
          )
        end

        private

        def decode_player(player)
          case player
          when :X then ::TicTacToe::PLAYER_X
          when :O then ::TicTacToe::PLAYER_O
          when :EMPTY then ::TicTacToe::EMPTY
          else
            raise "Bad Player"
          end
        end
      end

      def initialize(handler)
        @handler = handler
      end

      def play(game, _)
        decoded_game = self.class.decode_game(game)
        move = @handler.play(decoded_game)

        self.class.encode_move(move)
      end
    end
  end
end
