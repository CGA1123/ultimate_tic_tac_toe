module UltimateTicTacToe
  class GrpcPlayer
    def initialize(token:, stub:)
      @token = token
      @stub = stub
    end

    def play(board)
      move = @stub.play(encode_game(board))

      board.set(decode_move(move), @token)
    end

    private

    def encode_game(board)
      Protos::Game.new(
        available_moves: available_moves(board),
        game: game(board),
        state: state(board),
        player: player
      )
    end

    def decode_move(move)
      [move.big_index, move.small_index]
    end

    def available_moves(board)
      board.available_moves.map do |big, small|
        Protos::Move.new(big_index: big, small_index: small)
      end
    end

    def state(board)
      case board.state
      when :running
        Protos::State::RUNNING
      when :draw
        Protos::State::DRAW
      when :win
        board.winner == 'X' ? Protos::State::WIN_X : Protos::State::WIN_O
      else
        raise 'Bad State'
      end
    end

    def game(board)
      board.board.map { |b| encode_board(b) }
    end

    def encode_board(board)
      cells = board.board.map do |cell|
        case cell
        when Board::EMPTY
          Protos::Cell::EMPTY
        when 'X'
          Protos::Cell::CELL_X
        when 'O'
          Protos::Cell::CELL_O
        else
          raise 'Unknown Cell'
        end
      end

      Protos::Board.new(cells: cells, state: state(board))
    end

    def player
      case @token
      when 'X'
        Protos::Player::PLAYER_X
      when 'O'
        Protos::Player::PLAYER_O
      else
        raise 'Unknown Player'
      end
    end
  end
end
