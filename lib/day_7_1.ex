defmodule Day_7_1 do
  @moduledoc """
    Advent of Code
    Day 7 part 1
    https://adventofcode.com/2021/day/5
  """
  def part_1 do
    case File.read("./lib/day_7_1_input.txt") do
      {:error, reason} ->
        IO.puts(reason)

      {:ok, file} ->
        fileInput =
          file
          |> String.trim()
          |> String.split(",", trim: true)
          |> Enum.map(&String.to_integer/1)

        IO.inspect(fileInput, label: "File input")

        Enum.reduce(fileInput, -1, fn crab_position, leastFuel ->
          fuelCost =
            fileInput
            |> Enum.reduce(0, fn x, acc ->
              acc + abs(crab_position - x)
            end)
            |> IO.inspect(label: "#{crab_position} cost")

          IO.inspect(leastFuel, label: "Least")

          if(leastFuel == -1 or fuelCost < leastFuel) do
            fuelCost
          else
            leastFuel
          end
        end)
    end
  end
end
