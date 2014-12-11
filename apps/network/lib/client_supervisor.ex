defmodule Network.ClientSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_), do: supervise([], strategy: :one_for_one)

  def connected(sup, client), do: Supervisor.start_child(sup, worker(Network.Connection, [client]))
end
