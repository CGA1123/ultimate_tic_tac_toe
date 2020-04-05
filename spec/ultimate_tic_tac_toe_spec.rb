require "spec_helper"

RSpec.describe UltimateTicTacToe do
  describe ".empty_board" do
    subject(:empty_board) { described_class.empty_board }

    let(:empty_local_board) { Array.new(9) { described_class::EMPTY } }
    it "build an empty_board" do
      expect(empty_board.board).to contain_exactly(
        empty_local_board,
        empty_local_board,
        empty_local_board,
        empty_local_board,
        empty_local_board,
        empty_local_board,
        empty_local_board,
        empty_local_board,
        empty_local_board
      )
    end

    it "sets the player as X" do
      expect(empty_board.player).to eq(described_class::PLAYER_X)
    end

    it "sets the local_board_index as nil (any)" do
      expect(empty_board.local_board_index).to be_nil
    end
  end

  describe "#available_moves" do
    subject(:available_moves) { board.available_moves }

    context "on an empty board" do
      let(:board) { described_class.empty_board }

      let(:expected_moves) do
        (0..8).flat_map do |global_board|
          (0..8).map do |local_board|
            [global_board, local_board]
          end
        end
      end

      it "has all available moves" do
        expect(available_moves).to eq(expected_moves)
      end
    end

    context "when local_board_index is set" do
      let(:empty_board) { Array.new(9) { Array.new(9) { described_class::EMPTY } } }
      let(:board) { described_class.new(board: empty_board, player: described_class::PLAYER_X, local_board_index: 3, history: []) }
      let(:expected_moves) { (0..8).map { |index| [3, index] } }

      it "returns all empty cells in local board with index 3" do
        expect(available_moves).to eq(expected_moves)
      end
    end

    context "when some moves have been made" do
      let(:board) { described_class.new(board: used_board, player: described_class::PLAYER_X, local_board_index: 3, history: []) }
      let(:expected_moves) { [[3, 1], [3, 2], [3, 3], [3, 4], [3, 6], [3, 7], [3, 8]] }
      let(:used_board) do
        empty = Array.new(9) { Array.new(9) { described_class::EMPTY } }

        empty[3][0] = described_class::PLAYER_X
        empty[3][5] = described_class::PLAYER_O

        empty
      end

      it "returns all empty cells in local board with index 3" do
        expect(available_moves).to eq(expected_moves)
      end
    end
  end

  describe "#play" do
    subject(:play) { board.play(move) }

    context "when move is legal" do
      let(:board) { described_class.empty_board }
      let(:move) { [0, 0] }

      it "returns an instance" do
        expect(play).to be_a(described_class)
      end

      it "returns a different instance" do
        expect(play).not_to be(board)
      end

      it "sets the local_board_index to the index of the last local move" do
        expect(play.local_board_index).to eq(0)
      end

      it "sets the player to PLAYER_O" do
        expect(play.player).to eq(described_class::PLAYER_O)
      end

      it "set the board correctly" do
        empty_board = Array.new(9) { described_class::EMPTY }
        set_board = Array.new(9) { described_class::EMPTY }
        set_board[0] = described_class::PLAYER_X

        expect(play.board).to eq(
          [
            set_board,
            empty_board,
            empty_board,
            empty_board,
            empty_board,
            empty_board,
            empty_board,
            empty_board,
            empty_board
          ]
        )
      end

      it "does not change the current boards player" do
        expect { play }.not_to change(board, :player)
      end

      it "does not change the current boards board" do
        expect { play }.not_to change(board, :board)
      end

      it "does not change the current boards local_board_index" do
        expect { play }.not_to change(board, :local_board_index)
      end
    end

    context "when move is illegal" do
      let(:board) { described_class.empty_board.play([0, 0]) }
      let(:move) { [0, 0] }

      it "raises a bad move" do
        expect { play }.to raise_error(described_class::BadMove)
      end
    end

    context "when game is over due to win" do
      let(:move) { [8, 0] }
      let(:board) do
        x = described_class::PLAYER_X
        o = described_class::PLAYER_O
        d = described_class::EMPTY
        e = Array.new(9) { d }
        described_class.new(
          player: o,
          local_board_index: 8,
          history: [],
          board: [
            x, x, x,
            d, d, d,
            e, e, e
          ]
        )
      end

      it "raises a bad move" do
        expect { play }.to raise_error(described_class::BadMove)
      end
    end

    context "when game is over due to draw" do
      let(:move) { [8, 0] }
      let(:board) do
        x = described_class::PLAYER_X
        o = described_class::PLAYER_O
        d = described_class::EMPTY
        described_class.new(
          player: o,
          local_board_index: 8,
          history: [],
          board: [
            x, o, x,
            d, o, d,
            x, x, o
          ]
        )
      end

      it "raises a bad move" do
        expect { play }.to raise_error(described_class::BadMove)
      end
    end
  end
end
