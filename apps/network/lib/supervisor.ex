defmodule Network.Supervisor do
  use Supervisor

  def start_link do
    result = { :ok, sup } = Supervisor.start_link(__MODULE__, [])
    start_workers(sup)
    result
  end

  defp start_workers(sup) do
    { :ok, cs } = Supervisor.start_child(sup, supervisor(Network.ClientSupervisor, []))
    Supervisor.start_child(sup, worker(Network.Server, [cs]))
  end

  def init(_), do: supervise([], strategy: :one_for_one)
end
