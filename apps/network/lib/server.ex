defmodule Network.Server do

  def start_link(sup), do: spawn_link(fn -> start(sup) end)

  defp start(sup) do
    IO.puts "Server started on 4040"
    :gen_tcp.listen(4040, [:binary, packet: :line, active: false])
    |> accept_clients(sup)
  end

  defp accept_clients({ :ok, socket }, sup) do
    { :ok, client } = :gen_tcp.accept(socket)
    Network.ClientSupervisor.connected(sup, client)
    accept_clients({ :ok, socket }, sup)
  end

  defp accept_clients(_, _), do: { :error, "Socket didn't open" }

end
