case File.read("day_1_1_input.txt") do
  {:error, reason} ->
    IO.puts(reason)

  {:ok, file} ->
    file
    |> String.split("\n")
    |> Enum.drop(-1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(3, 1)
    |> Enum.reduce(%{last: nil, count: 0}, fn chunk, acc ->
      case Enum.sum(chunk) do
        x when x > acc.last -> %{last: x, count: acc.count + 1}
        x -> %{last: x, count: acc.count}
      end
    end)
    |> Map.fetch!(:count)
    |> IO.puts()
end
