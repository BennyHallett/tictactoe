defmodule Game.Board do

  def new, do: 1..9 |> Enum.map &none/1
  
  def result([a, a, a, _, _, _, _, _, _]) when a != nil, do: a
  def result([_, _, _, a, a, a, _, _, _]) when a != nil, do: a
  def result([_, _, _, _, _, _, a, a, a]) when a != nil, do: a
  def result([a, _, _, a, _, _, a, _, _]) when a != nil, do: a
  def result([_, a, _, _, a, _, _, a, _]) when a != nil, do: a
  def result([_, _, a, _, _, a, _, _, a]) when a != nil, do: a
  def result([a, _, _, _, a, _, _, _, a]) when a != nil, do: a
  def result([_, _, a, _, a, _, a, _, _]) when a != nil, do: a
  def result(a), do: _result(Enum.any?(a, fn i -> i == nil end))
  defp _result(true), do: :inconclusive
  defp _result(false), do: :draw

  defp none(_), do: nil


end
