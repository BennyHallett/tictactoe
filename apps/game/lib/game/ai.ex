defmodule Game.Ai do

  def start(name, token), do: spawn_link(_start(name, token))

  def _start(name, token) do
    receive do
      { sender, command, args } ->
        process_command sender, command, args, name, token
    end
    _start(name, token)
  end

  defp process_command(sender, :your_turn, board, _name, token), do: make_move(sender, board, token)
  defp process_command(_sender, command, _args, name, _token) do
    messages_for(command)
    |> Enum.shuffle
    |> hd
    |> format_message(name)
    |> IO.puts

    exit(:finished)
  end

  defp format_message(msg, name), do: "#{name}: #{msg}"

  defp messages_for(:you_win), do: ["YAY, I win!", "Winner winner chicken dinner", "Yessssss!", "I am the champion, my friend!"]
  defp messages_for(:you_lose), do: ["Oh no, I've lost", "Ah drats!", "I wasn't even trying", "I'll get you next time!"]
  defp messages_for(:draw), do: ["Close match.", "Play again?", "We're evenly matched."]

  defp make_move(sender, board, token), do: 0..8 |> Enum.shuffle |> hd |> _make_move(sender, board, token)
  defp _make_move(pos, sender, board, token), do: confirm_move(sender, board, Enum.at(board, pos), pos, token)
  
  defp confirm_move(sender, _board, nil, pos, token), do: send(sender, { :my_move, pos, token })
  defp confirm_move(sender, board, _, _, token), do: make_move(sender, board, token)

end
