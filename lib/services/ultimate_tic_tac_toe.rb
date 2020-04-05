module Services
  module UltimateTicTacToe
    class Player < ProtocolBuffers::UltimateTicTacToe::PlayerService::Service
      class << self
        def encode_move(move)
          ProtocolBuffers::UltimateTicTacToe::Move.new(
            global_index: move[0],
            local_index: move[1]
          )
        end

        def decode_game(game)
          local_board_index = game.any_local_board ? nil : game.local_board_index
          ::UltimateTicTacToe.new(
            player: decode_player(game.player),
            local_board_index: local_board_index,
            board: game.board.map { |local_board| decode_board(local_board) }
          )
        end

        private

        def decode_board(board)
          decoded = board.cells.map { |cell| decode_player(cell) }

          if decoded.size == 1
            decoded.first
          else
            decoded
          end
        end

        def decode_player(player)
          case player
          when :X then ::UltimateTicTacToe::PLAYER_X
          when :O then ::UltimateTicTacToe::PLAYER_O
          when :EMPTY then ::UltimateTicTacToe::EMPTY
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
