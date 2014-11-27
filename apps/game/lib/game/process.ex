defmodule Game.Process do

  def start(p1, p2), do: spawn(fn -> _start(p1, p2, Game.Board.new, true) end)

  def _start(p1, p2, board, p1_turn) do
    send(p1, { self, :your_turn, board })
    receive do
      { :ok, {:my_move, pos, token } } ->
        board = List.update_at(board, pos, fn _ -> token end)
    end
    send(p2, { self, :your_turn, board })
    receive do
      { :ok, { :my_move, pos, token } } ->
        board = List.update_at(board, pos, fn _ -> token end)
    end

    IO.puts "The game is now: #{board}"
  end

end
