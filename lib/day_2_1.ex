defmodule Day_2 do
  @moduledoc """
  """
  def sum_result(res) do
    Map.fetch!(res, :depth) * Map.fetch!(res, :horizontal_pos)
  end

  def day2_1 do
    case File.read("./lib/day_2_1_input.txt") do
      {:error, reason} ->
        IO.puts("-- error:")
        IO.puts(reason)

      {:ok, file} ->
        file
        |> String.split("\n")
        |> Enum.drop(-1)
        |> Enum.map(fn x ->
          val = String.split(x, " ", trim: true)
          %{command: Enum.at(val, 0), value: String.to_integer(Enum.at(val, 1))}
        end)
        |> Enum.reduce(%{horizontal_pos: 0, depth: 0}, fn x, acc ->
          case x do
            %{command: "forward", value: x} ->
              %{horizontal_pos: acc.horizontal_pos + x, depth: acc.depth}

            %{command: "up", value: x} ->
              %{horizontal_pos: acc.horizontal_pos, depth: acc.depth - x}

            %{command: "down", value: x} ->
              %{horizontal_pos: acc.horizontal_pos, depth: acc.depth + x}

            _ ->
              acc
          end
        end)
        |> sum_result()
        |> IO.puts()
    end
  end
end
