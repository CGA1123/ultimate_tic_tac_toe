class UltimateTicTacToe
  class GrpcPlayer
    class << self
      def encode_game(game)
        ProtocolBuffers::UltimateTicTacToe::Game.new(
          player: encode_player(game.player),
          board: game.board.map { |board| encode_board(board) },
          any_local_board: game.local_board_index.nil?,
          local_board_index: game.local_board_index,
          history: game.history.map { |g, l| ProtocolBuffers::UltimateTicTacToe::Move.new(global_index: g, local_index: l) }
        )
      end

      def decode_move(move)
        [move.global_index, move.local_index]
      end

      private

      def encode_board(board)
        ProtocolBuffers::UltimateTicTacToe::Board.new(
          cells: Array(board).map { |cell| encode_player(cell) }
        )
      end

      def encode_player(player)
        case player
        when UltimateTicTacToe::EMPTY then :EMPTY
        when UltimateTicTacToe::PLAYER_X then :X
        when UltimateTicTacToe::PLAYER_O then :O
        else
          raise "Bad Player"
        end
      end
    end

    attr_reader :name

    def initialize(address, name: "grpc_player:#{address}")
      @name = name
      @stub = ProtocolBuffers::UltimateTicTacToe::PlayerService::Stub.new(
        address, :this_channel_is_insecure
      )
    end

    def play(game)
      encoded_game = self.class.encode_game(game)
      move = @stub.play(encoded_game)

      self.class.decode_move(move)
    end
  end
end
