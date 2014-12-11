defmodule Network.Connection do
  use GenServer

  def start_link(tcp_client) do
    :gen_tcp.send(tcp_client, "What is your name? ")
    { :ok, name } = :gen_tcp.recv(tcp_client, 0)

    :gen_tcp.send(tcp_client, "Would you like to play a game? (y/n) ")
    { :ok, play } = :gen_tcp.recv(tcp_client, 0)

    if String.strip(play) == "y" do
      { :ok, pid } = GenServer.start_link(__MODULE__, :ok, {tcp_client, name})
      p1 = Game.NetworkPlayer.start_link name, "X", pid
      p2 = Game.Ai.start_link "CPU", "O"
      Game.Factory.start_game p1, p2
    else
      :gen_tcp.close(tcp_client)
    end
  end

  def send(pid, message), do: GenServer.cast(pid, { :send, message })

  def receive(pid), do: GenServer.call(pid, :receive)

  def handle_cast({ :send, message }, _from, { tcp_client, name }) do
    :gen_tcp.send(tcp_client, message)
    { :noreply, { tcp_client, name } }
  end

  def handle_call(:receive, _from, { tcp_client, name }) do
    { :ok, response } = :gen_tcp.recv(tcp_client, 0)
    { :reply, response, { tcp_client, name } }
  end

end
