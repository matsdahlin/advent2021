case File.read("day_1_1_input.txt") do
  {:error, reason} ->
    IO.puts(reason)

  {:ok, file} ->
    file
    |> String.split("\n")
    |> Enum.reduce(%{last: nil, count: 0}, fn s, acc ->
      case s do
        x when x > acc.last -> %{last: s, count: acc.count + 1}
        _ -> %{last: s, count: acc.count}
      end
    end)
    |> Map.fetch!(:count)
    |> IO.puts()
end
