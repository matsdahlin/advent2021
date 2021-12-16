defmodule Day_9_1 do
  @moduledoc """
    Advent of Code
    Day 9 part 1
    https://adventofcode.com/2021/day/9
  """
  def part_1 do
    case File.read("./lib/day_9_1_input.txt") do
      {:error, reason} ->
        IO.puts(reason)

      {:ok, file} ->
        rows = String.split(file, "\n", trim: true)
        # Got this from Valims stream, trying to digest exactly how the syntax works
        grid =
          for {line, row} <- Enum.with_index(rows),
              {number, col} <- Enum.with_index(String.to_char_list(line)),
              into: %{} do
            # ?0 to convert char to int?
            {{row, col}, number - ?0}
          end

        grid
        |> Enum.filter(fn {{row, col}, value} ->
          up = grid[{row - 1, col}]
          down = grid[{row + 1, col}]
          left = grid[{row, col - 1}]
          right = grid[{row, col + 1}]
          value < up and value < down and value < left and value < right
        end)
        |> Enum.map(fn {_, height} -> height + 1 end)
        |> Enum.sum()
        |> IO.inspect(label: "Sum of lowest")
    end
  end
end
