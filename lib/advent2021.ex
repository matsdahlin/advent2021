defmodule Advent2021 do
  @moduledoc """
  Documentation for `Advent2021`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Advent2021.hello()
      :world

  """
  def hello do
    {:ok, file} = File.read("input.txt")

    file
    |> String.split("\n")
    |> IO.puts()
  end
end
