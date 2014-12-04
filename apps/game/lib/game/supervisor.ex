defmodule Game.Supervisor do
  use Supervisor

    def start_link do
      result = { :ok, sup } = Supervisor.start_link(__MODULE__, [])
      start_workers(sup)
      result
    end

    def start_workers(sup) do
      { :ok, is } = Supervisor.start_child(sup,  supervisor(Game.InstanceSupervisor, []))
      Supervisor.start_child(sup, worker(Game.Factory, [is]))
    end

    def init(_), do: supervise([], strategy: :one_for_one)

end
