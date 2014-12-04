defmodule Game.InstanceSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init(_), do: supervise([], strategy: :one_for_one)

  def start_game(sup, p1, p2), do: Supervisor.start_child(sup, worker(Game.Process, [p1, p2]))

end
