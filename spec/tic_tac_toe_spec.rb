require "spec_helper"

RSpec.describe TicTacToe do
  describe ".empty_board" do
    subject(:empty_board) { described_class.empty_board }

    it "builds an empty board" do
      expect(empty_board.board).to all(eq(described_class::EMPTY))
    end

    it "has nine cells" do
      expect(empty_board.board.size).to eq(9)
    end

    it "is player x's turn" do
      expect(empty_board.player).to eq(described_class::PLAYER_X)
    end

    it "has an empty history" do
      expect(empty_board.history).to be_empty
    end
  end

  describe "#available_moves" do
    subject(:available_moves) { board.available_moves }

    described_class::WINS.each do |win|
      context "when game is winning with #{win}" do
        let(:board) do
          empty_game = described_class.empty_board
          available_moves = empty_game.available_moves - win
          moves = win.zip(available_moves).flatten.take(5)

          moves.reduce(empty_game) { |game, move| game.play(move) }
        end

        it "is empty" do
          expect(available_moves).to eq([])
        end
      end
    end

    context "when the board is empty" do
      let(:board) { described_class.empty_board }

      it "has all moves available" do
        expect(available_moves).to eq(
          [0, 1, 2, 3, 4, 5, 6, 7, 8]
        )
      end
    end

    context "after a couple of turns" do
      let(:board) do
        described_class
          .empty_board
          .play(4)
          .play(0)
          .play(7)
      end

      it "returns only available moves" do
        expect(available_moves).to eq(
          [1, 2, 3, 5, 6, 8]
        )
      end
    end
  end

  describe "#play" do
    subject(:play) { game.play(move) }

    context "when move is legal" do
      let(:move) { 0 }
      let(:game) { described_class.empty_board }

      it "returns a board" do
        expect(play).to be_a(described_class)
      end

      it "returns a different board" do
        expect(play).not_to be(game)
      end

      it "does not change the internal game" do
        expect { play }.not_to change(game, :board)
      end

      it "does not change the player of the original game" do
        expect { play }.not_to change(game, :player)
      end

      it "does not change the history of the original game" do
        expect { play }.not_to change(game, :history)
      end

      it "updates the history" do
        expect(play.history).to eq([0])
      end

      it "returns a board with move made" do
        expect(play.board).to eq(
          [
            described_class::PLAYER_X,
            described_class::EMPTY,
            described_class::EMPTY,
            described_class::EMPTY,
            described_class::EMPTY,
            described_class::EMPTY,
            described_class::EMPTY,
            described_class::EMPTY,
            described_class::EMPTY,
          ]
        )
      end

      it "returns a board with player changed" do
        expect(play.player).to eq(described_class::PLAYER_O)
      end
    end

    context "when move is illegal" do
      let(:move) { 0 }
      let(:game) { described_class.empty_board.play(move) }

      it "raises a bad move" do
        expect { play }.to raise_error(described_class::BadMove)
      end
    end
  end

  describe "#state" do
    subject(:state) { game.state }

    context "at the beginning of the game" do
      let(:game) { described_class.empty_board }

      it "is running" do
        expect(state).to eq(described_class::STATE_RUNNING)
      end
    end

    context "after a couple of moves" do
      let(:game) do
        described_class
          .empty_board
          .play(0)
          .play(1)
          .play(2)
          .play(4)
      end

      it "has set the history correctly (latest last)" do
        expect(game.history).to eq([0, 1, 2, 4])
      end

      it "is running" do
        expect(state).to eq(described_class::STATE_RUNNING)
      end
    end

    context "when game is a draw" do
      let(:game) do
        [0, 3, 1, 4, 5, 2, 6, 7, 8]
          .reduce(described_class.empty_board) { |game, move| game.play(move) }
      end

      it "is a draw" do
        expect(state).to eq(described_class::STATE_DRAW)
      end
    end

    described_class::WINS.each do |win|
      context "when game is winning with #{win}" do
        let(:game) do
          empty_game = described_class.empty_board
          available_moves = empty_game.available_moves - win
          moves = win.zip(available_moves).flatten.take(5)

          moves.reduce(empty_game) { |game, move| game.play(move) }
        end

        it "is win" do
          expect(state).to eq(described_class::STATE_WIN)
        end
      end
    end
  end
end
