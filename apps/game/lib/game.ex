defmodule Game do
  use Application

  def start(_type, _args) do
    Game.Supervisor.start_link
  end
end
