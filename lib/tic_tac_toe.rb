class TicTacToe
  autoload :Printer, "tic_tac_toe/printer"
  autoload :Game, "tic_tac_toe/game"
  autoload :RandomPlayer, "tic_tac_toe/random_player"
  autoload :ConsolePlayer, "tic_tac_toe/console_player"
  autoload :MonteCarloPlayer, "tic_tac_toe/monte_carlo_player"
  autoload :GrpcPlayer, "tic_tac_toe/grpc_player"

  BadMove = Class.new(StandardError)

  STATES = [
    STATE_WIN = Object.new,
    STATE_DRAW = Object.new,
    STATE_RUNNING = Object.new,
  ].freeze

  EMPTY = Object.new
  PLAYERS = [
    PLAYER_X = Object.new,
    PLAYER_O = Object.new,
  ].freeze

  WINS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ].map(&:freeze).freeze

  def self.empty_board
    new(
      board: Array.new(9) { EMPTY },
      player: PLAYER_X
    )
  end

  attr_reader :board, :player

  def initialize(board:, player:)
    @board = board.map(&:freeze).freeze
    @player = player
  end

  def available_moves
    return [] unless state == STATE_RUNNING

    @available_moves ||=
      @board
        .map
        .with_index
        .select { |t, _| t == EMPTY }
        .map { |_, i| i }
  end

  def play(move)
    ensure_valid_move!(move)

    new_board = @board.dup
    new_board[move] = player

    self.class.new(
      board: new_board,
      player: opposite_player
    )
  end

  def state
    @state ||=
      if win?
        STATE_WIN
      elsif @board.none? { |x| x == EMPTY }
        STATE_DRAW
      else
        STATE_RUNNING
      end
  end

  def running?
    state == STATE_RUNNING
  end

  def draw?
    state == STATE_DRAW
  end

  def win?
    return @win if defined?(@win)

    @win =
      WINS
        .map { |x, y, z| [@board[x], @board[y], @board[z]].uniq }
        .any? { |x| (x.size == 1) && x.first != EMPTY }
  end

  def winner
    return unless win?

    opposite_player
  end

  private

  def ensure_valid_move!(move)
    return if available_moves.include?(move)

    raise BadMove, "#{move} is not a valid move."
  end

  def opposite_player
    @player == PLAYER_X ? PLAYER_O : PLAYER_X
  end
end
