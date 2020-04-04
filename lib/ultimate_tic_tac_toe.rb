class UltimateTicTacToe
  BadMove = Class.new(StandardError)

  EMPTY = Object.new
  PLAYERS = [
    PLAYER_X = Object.new,
    PLAYER_O = Object.new
  ]

  WINS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ].map(&:freeze).freeze

  STATES = [
    STATE_WIN = Object.new,
    STATE_DRAW = Object.new,
    STATE_RUNNING = Object.new
  ].freeze

  def self.empty_board
    new(
      board: Array.new(9) { Array.new(9) { EMPTY } },
      player: PLAYER_X,
      local_board_index: nil
    )
  end

  attr_reader :board, :player, :local_board_index

  def initialize(board:, player:, local_board_index:)
    @board = board
    @player = player
    @local_board_index = local_board_index
  end

  def play(move)
    ensure_valid_move!(move)

    global_index = move[0]
    local_index = move[1]

    new_board = build_new_board(global_index, local_index)
    new_local_board_index =
      if new_board[local_index].is_a?(Array)
        local_index
      else
        nil
      end

    self.class.new(
      player: opponent,
      local_board_index: new_local_board_index,
      board: new_board
    )
  end

  def available_moves
    return [] unless running?

    @available_moves ||=
      if local_board_index.nil?
        @board.flat_map.with_index do |local_board, global_index|
          local_available_moves(local_board)
            .map { |local_index| [global_index, local_index] }
        end
      else
        local_available_moves(@board[local_board_index])
          .map { |local_index| [local_board_index, local_index] }
      end
  end

  def state
    @state ||=
      if win?
        STATE_WIN
      elsif @board.none? { |x| x.is_a?(Array) }
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
        .any? { |x| (x.size == 1) && !x.first.is_a?(Array) && x.first != EMPTY }
  end

  def winner
    return unless win?

    opposite
  end

  private

  def build_new_board(global_index, local_index)
    new_global_board = @board.map(&:itself)
    new_local_board = new_global_board[global_index].map(&:itself)
    new_local_board[local_index] = @player

    if check_win?(new_local_board)
      new_global_board[global_index] = @player
    elsif new_local_board.none? { |x| x == EMPTY }
      new_global_board[global_index] = EMPTY
    else
      new_global_board[global_index] = new_local_board
    end

    new_global_board
  end

  def opponent
    @player == PLAYER_X ? PLAYER_O : PLAYER_X
  end

  def check_win?(board)
    WINS
      .map { |x, y, z| [board[x], board[y], board[z]].uniq }
      .any? { |x| (x.size == 1) && x.first != EMPTY }
  end

  def local_available_moves(local_board)
    return [] unless local_board.is_a?(Array)

    local_board
      .map
      .with_index
      .select { |cell, _| cell == EMPTY }
      .map { |_, local_index| local_index }
  end

  def ensure_valid_move!(move)
    return if available_moves.include?(move)

    raise BadMove, "#{move.inspect} is not an available move"
  end
end
