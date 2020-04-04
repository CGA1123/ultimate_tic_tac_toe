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

  def self.empty_board; end

  def initialize; end
  def play(move); end
  def available_moves; end
  def state; end
  def running?; end
  def draw?; end
  def win?; end
  def winner; end
end
