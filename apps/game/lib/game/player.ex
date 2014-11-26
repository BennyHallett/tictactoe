defmodule Game.Player do

  def start(name, token), do: spawn_link(_start(name, token))

  def _start(name, token) do
    receive do
      { sender, command, args } ->
        process_command sender, command, args, name, token
    end
    _start(name, token)
  end

  defp process_command(sender, :your_turn, board, _, token), do: make_move(sender, board, token)
  defp process_command(_sender, :you_win, _args, _, _), do: exit_with("You win!")
  defp process_command(_sender, :you_lose, _args, _, _), do: exit_with("You lost!")
  defp process_command(_sender, :draw, _args, _, _), do: exit_with("It was a draw")

  defp exit_with(msg) do
    msg |> IO.puts
    exit(:finished)
  end

  defp make_move(sender, board, token) do
    Game.Board.draw(board) |> IO.puts
    { pos, _ } = "Which position would you like to play?: "
    |> IO.gets
    |> String.strip
    |> Integer.parse

    play_pos(pos, board, token, sender)
  end

  defp play_pos(pos, board, token, sender), do: _play_pos(board, token, pos, sender, Enum.at(board, pos) == nil)
  defp _play_pos(_board, token, pos, sender, true), do: send(sender, { :ok, { :my_move, pos, token } })
  defp _play_pos(board, token, _, sender, false) do
    { pos, _ } = "That position was taken. Please choose again: "
    |> IO.gets
    |> String.strip
    |> Integer.parse

    play_pos(pos, board, token, sender)
  end

end
