defmodule Game.Process do

  def start_link(p1, p2), do: spawn_link(fn -> _start(p1, p2, Game.Board.new, true) end)

  def _start(p1, p2, board, p1_turn) do
    if p1_turn do
      send(p1, { self, :your_turn, board })
    else
      send(p2, { self, :your_turn, board })
    end

    receive do
      {:my_move, pos, token } ->
        board = List.update_at(board, pos, fn _ -> token end)
    end

    Game.Board.result(board)
    |> finish_or_continue(p1, p2, board, p1_turn)
  end

  defp finish_or_continue(:inconclusive, p1, p2, board, p1_turn) do
    _start(p1, p2, board, !p1_turn)
  end
  defp finish_or_continue(:draw, _, _, board, _) do
    IO.puts "It was a draw"
    IO.puts "Final state is:\n#{Game.Board.draw(board)}"
  end
  defp finish_or_continue("X", p1, p2, board, _) do
    send(p1, { self, :you_win, nil })
    send(p2, { self, :you_lose, nil })
    IO.puts "Final state is:\n#{Game.Board.draw(board)}"
  end
  defp finish_or_continue("O", p1, p2, board, _) do
    send(p2, { self, :you_win, nil })
    send(p1, { self, :you_lose, nil })
    IO.puts "Final state is:\n#{Game.Board.draw(board)}"
  end
  defp finish_or_continue(_, _, _, board, _) do
    IO.puts "Game has finished"
    IO.puts "Final state is:\n#{Game.Board.draw(board)}"
  end

end
