defmodule Game.NetworkPlayer do

    def start(name, token, connection), do: spawn(fn -> _start(name, token, connection) end)

    def _start(name, token, connection) do
      receive do
        { sender, command, args } ->
          process_command sender, command, args, name, token, connection
      end
      _start(name, token, connection)
    end

    defp process_command(sender, :your_turn, board, _, token, connection), do: make_move(sender, board, token, connection)
    defp process_command(_, :you_win, board, _, _, connection), do: exit_with("You won!", board, connection)
    defp process_command(_, :you_lose, board, _, _, connection), do: exit_with("You lost", board, connection)
    defp process_command(_, :you_draw, board, _, _, connection), do: exit_with("It was a draw", board, connection)

    defp exit_with(msg, board, connection) do
      connection
      |> Network.Connection.send("#{msg}\n\n#{Game.Board.draw(board)}")
      exit(:finished)
    end

    defp make_move(sender, board, token, connection) do
      connection
      |> Network.Connection.send("#{Game.Board.draw(board)}")

      connection
      |> Network.Connection.send("Which Position would you like to play?: ")

      { pos, _ } = connection
      |> Network.Connection.receive
      |> String.strip
      |> Integer.parse

      play_pos(pos, board, token, sender, connection)
    end

    defp play_pos(pos, board, token, sender, connection), do: _play_pos(board, token, pos, sender, connection, Enum.at(board, pos) == nil)
    defp _play_pos(_, token, pos, sender, _, true), do: send(sender, { :my_move, pos, token })
    defp _play_pos(board, token, _, sender, connection, false) do
      connection
      |> Network.Connection.send("That position was taken, Please choose again: ")

      { pos, _ } = connection
      |> Network.Connection.receive
      |> String.strip
      |> Integer.parse

      play_pos(pos, board, token, sender, connection)
    end

end
