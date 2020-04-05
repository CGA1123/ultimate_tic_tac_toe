class TicTacToe
  class GrpcPlayer
    class << self
      def encode_game(game)
        ProtocolBuffers::TicTacToe::Game.new(
          player: encode_player(game.player),
          board: game.board.map { |cell| encode_player(cell) },
          history: game.history.map { |move| ProtocolBuffers::TicTacToe::Move.new(index: move) }
        )
      end

      def decode_move(move)
        move.index
      end

      private

      def encode_player(player)
        case player
        when TicTacToe::EMPTY then :EMPTY
        when TicTacToe::PLAYER_X then :X
        when TicTacToe::PLAYER_O then :O
        else
          raise "Bad Player"
        end
      end
    end

    attr_reader :name

    def initialize(address, name: "grpc_player:#{address}")
      @name = name
      @stub = ProtocolBuffers::TicTacToe::PlayerService::Stub.new(
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
