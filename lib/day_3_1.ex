use Bitwise

defmodule Day_3_1 do
  @moduledoc """
  """
  def sum_result(res) do
    Map.fetch!(res, :depth) * Map.fetch!(res, :horizontal_pos)
  end

  def day3_1 do
    case File.read("./lib/day_3_1_input.txt") do
      {:error, reason} ->
        IO.puts(reason)

      {:ok, file} ->
        gammaRateBinary =
          file
          |> String.split("\n", trim: true)
          |> Enum.map(fn x ->
            x
            |> String.graphemes()
            |> Enum.map(&String.to_integer/1)
          end)
          |> Enum.zip()
          |> Enum.map(&Tuple.to_list/1)
          |> Enum.map(fn x ->
            rowLength = Enum.count(x) / 2

            case Enum.sum(x) do
              x when x > rowLength -> 1
              _ -> 0
            end
          end)

        epsilonRate =
          gammaRateBinary
          |> Enum.map(fn x ->
            case x do
              0 -> 1
              _ -> 0
            end
          end)
          |> Enum.join()
          |> Integer.parse(2)
          |> elem(0)
          |> IO.inspect(label: "epRate")

        gammaRate =
          gammaRateBinary
          |> Enum.join()
          |> Integer.parse(2)
          |> elem(0)
          |> IO.inspect(label: "gaRate")

        result = epsilonRate * gammaRate
        IO.puts(result)
    end
  end
end
