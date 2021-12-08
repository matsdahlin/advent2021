defmodule Day_6_1 do
  @moduledoc """
    Advent of Code
    Day 6 part 1
    https://adventofcode.com/2021/day/5
  """
  def simulate_day(fishes, n) when n > 0 do
    if(rem(n, 10) == 0) do
      IO.puts("simulating day #{10 - n}")
    end

    fishCount =
      fishes
      |> Enum.count(&(&1 == 0))

    additionalFishes = List.duplicate(8, fishCount)

    newFishes =
      fishes
      |> Enum.map(fn
        x when x == 0 -> 6
        x -> x - 1
      end)

    newFishState = additionalFishes ++ newFishes

    simulate_day(newFishState, n - 1)
  end

  def simulate_day(newFishes, 0) do
    newFishes
  end

  def part_1 do
    case File.read("./lib/day_6_1_input.txt") do
      {:error, reason} ->
        IO.puts(reason)

      {:ok, file} ->
        fileInput =
          file
          |> String.trim()
          |> String.split(",", trim: true)
          |> Enum.map(&String.to_integer/1)

        IO.inspect(fileInput)

        simulate_day(fileInput, 80)
        |> Enum.count()
    end
  end
end
