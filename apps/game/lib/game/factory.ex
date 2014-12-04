defmodule Game.Factory do
  use GenServer

  def start_link(sup), do: GenServer.start_link(__MODULE__, sup, name: __MODULE__)

  def start_game(p1, p2), do: GenServer.cast(__MODULE__, { :start_game, { p1, p2 } })

  def handle_cast({ :start_game, { p1, p2 } }, sup) do
    Game.InstanceSupervisor.start_game(sup, p1, p2)
  end

end
