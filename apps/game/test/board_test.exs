defmodule BoardTest do
  use ExUnit.Case

  test "Initial board has 9 empty spaces" do
    expected = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
    assert expected == Game.Board.new
  end

  test "Result of a new game is inconclusive" do
    board = Game.Board.new
    assert :inconclusive == Game.Board.result(board)
  end

  test "Three x across top wins" do
    board = ["X", "X", "X", nil, nil, "X", nil, "X", nil]
    assert "X" == Game.Board.result(board)
  end

  test "Three o across top wins" do
    board = ["X", "X", "X", nil, nil, "X", nil, "X", nil]
    assert "X" == Game.Board.result(board)
  end

  test "Three x across mid wins" do
    board = [nil, nil, nil, "X", "X", "X", nil, "O", nil]
    assert "X" == Game.Board.result(board)
  end

  test "Three o across mid wins" do
    board = [nil, nil, nil, "X", "X", "X", nil, "X", nil]
    assert "X" == Game.Board.result(board)
  end

  test "Three x across bottom wins" do
    board = [nil, "O", "O", "O", nil, nil, "X", "X", "X"]
    assert "X" == Game.Board.result(board)
  end

  test "Three o across bottom wins" do
    board = [nil, "X", "X", "X", nil, nil, "O", "O", "O"]
    assert "O" == Game.Board.result(board)
  end

  test "Three x down left wins" do
    board = ["X", "O", "O", "X", nil, nil, "X", "O", nil]
    assert "X" == Game.Board.result(board)
  end

  test "Three o down left wins" do
    board = ["O", "X", "X", "O", nil, nil, "O", "X", nil]
    assert "O" == Game.Board.result(board)
  end

  test "Three x down mid wins" do
    board = [nil, "X", "O", "O", "X", nil, "O", "X", nil]
    assert "X" == Game.Board.result(board)
  end

  test "Three o down mid wins" do
    board = [nil, "O", "X", "X", "O", nil, "X", "O", nil]
    assert "O" == Game.Board.result(board)
  end

  test "Three x down right wins" do
    board = [nil, "O", "X", nil, nil, "X", "X", "O", "X"]
    assert "X" == Game.Board.result(board)
  end

  test "Three o down right wins" do
    board = [nil, "X", "O", nil, nil, "O", "O", "X", "O"]
    assert "O" == Game.Board.result(board)
  end

  test "Three x top-left bottom-right wins" do
    board = ["X", "X", "O", nil, "X", "O", nil, "O", "X"]
    assert "X" == Game.Board.result(board)
  end

  test "Three o top-left bottom-right wins" do
    board = ["O", "O", "X", nil, "O", "X", nil, "X", "O"]
    assert "O" == Game.Board.result(board)
  end

  test "Three x top-right bottom-left wins" do
    board = ["O", "X", "X", nil, "X", "O", "X", "O", nil]
    assert "X" == Game.Board.result(board)
  end

  test "Three o top-right bottom-left wins" do
    board = ["X", "O", "O", nil, "O", "X", "O", "X", nil]
    assert "O" == Game.Board.result(board)
  end

  test "a draw" do
    board = ["X", "O", "O", "O", "X", "X", "O", "X", "O"]
    assert :draw == Game.Board.result(board)
  end

end
