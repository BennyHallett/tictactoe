defmodule Game.Process do

  def start_link(p1, p2), do: spawn_link(fn -> _start(p1, p2, Game.Board.new, true) end)

  def _start(p1, p2, board, p1_turn) do
    IO.puts "Starting Game"
    send(p1, { self, :your_turn, board })
    IO.puts "Sent message to p1"
    receive do
      {:my_move, pos, token } ->
        board = List.update_at(board, pos, fn _ -> token end)
    end
    IO.puts "Got p1 response, sending p2"
    send(p2, { self, :your_turn, board })
    receive do
      { :my_move, pos, token } ->
        board = List.update_at(board, pos, fn _ -> token end)
    end
    IO.puts "Got p2, finishing"

    IO.puts "The game is now: #{Enum.join(board, " ")}"
  end

end
