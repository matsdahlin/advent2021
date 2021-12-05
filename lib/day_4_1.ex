use Bitwise

defmodule Day_4_1 do
  @moduledoc """
  """

  def sum_result(res) do
    Map.fetch!(res, :depth) * Map.fetch!(res, :horizontal_pos)
  end

  def check_board(board, drawnNumbers) do
    IO.inspect(drawnNumbers, label: "inc drawn")
    IO.inspect(board, label: "inc board")
    # Check rows
    rowMatch =
      board
      |> Enum.any?(
        &Enum.all?(&1, fn y ->
          Enum.member?(drawnNumbers, y)
        end)
      )

    columnMatch =
      board
      |> Enum.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> IO.inspect(label: "After zip")
      |> Enum.any?(
        &Enum.all?(&1, fn y ->
          Enum.member?(drawnNumbers, y)
        end)
      )

    IO.inspect(rowMatch, label: "rows after filter")
    IO.inspect(columnMatch, label: "columns after filter")

    # isWinner =
    #   if rowMatch or columnMatch do
    #     :ok
    #   else
    #     nil
    #   end

    # {isWinner, board}
    rowMatch or columnMatch
  end

  def getBoardUnmarkedSum(board, matches) do
    boardSum =
      board
      |> List.flatten()
      |> Enum.filter(fn x -> !Enum.member?(matches, x) end)
      |> Enum.sum()

    lastNumberDrawn = Enum.take(matches, -1) |> Enum.at(0)

    lastNumberDrawn * boardSum
  end

  def drawNumber(bingoNumbers, boards) do
    recurseBoards(boards, bingoNumbers, 1)
  end

  def recurseBoards(boards, bingoNumbers, currentDraw) do
    drawnNumbers = Enum.take(bingoNumbers, currentDraw)
    inspect(drawnNumbers, label: "Current draw")
    isWinner = Enum.find(boards, &check_board(&1, drawnNumbers))
    IO.inspect(isWinner, label: "IS_WINNER")

    case isWinner do
      nil -> recurseBoards(boards, bingoNumbers, currentDraw + 1)
      board -> {board, drawnNumbers}
    end
  end

  def day4_1 do
    case File.read("./lib/day_4_1_input.txt") do
      {:error, reason} ->
        IO.puts(reason)

      {:ok, file} ->
        fileInput =
          file
          |> String.split("\n", trim: true)

        [numberSequence | tail] = fileInput

        parsedNumberSequence =
          numberSequence
          |> String.split(",", trim: true)
          |> Enum.map(&String.to_integer/1)

        IO.inspect(parsedNumberSequence)

        boards =
          tail
          |> Enum.map(fn x ->
            x
            |> String.split(" ", trim: true)
            |> Enum.map(&String.to_integer/1)
          end)
          |> Enum.chunk_every(5)
          |> IO.inspect(label: "tail")

        {winningBoard, drawnNumbers} = drawNumber(parsedNumberSequence, boards)
        IO.inspect(drawnNumbers, label: "Winning board")
        getBoardUnmarkedSum(winningBoard, drawnNumbers)
        # |> Enum.map(fn x ->
        #   x
        #   |> String.graphemes()
        #   |> Enum.map(&String.to_integer/1)
        # end)
        # |> Enum.zip()
        # |> Enum.map(&Tuple.to_list/1)
        # |> Enum.map(fn x ->
        #   rowLength = Enum.count(x) / 2

        #   case Enum.sum(x) do
        #     x when x > rowLength -> 1
        #     _ -> 0
        #   end
        # end)

        # epsilonRate =
        # gammaRateBinary
        # |> Enum.map(fn x ->
        #   case x do
        #     0 -> 1
        #     _ -> 0
        #   end
        # end)
        # |> Enum.join()
        # |> Integer.parse(2)
        # |> elem(0)
        # |> IO.inspect(label: "epRate")

        # gammaRate =
        # gammaRateBinary
        # |> Enum.join()
        # |> Integer.parse(2)
        # |> elem(0)
        # |> IO.inspect(label: "gaRate")

        # result = epsilonRate * gammaRate
        # IO.puts(result)
    end
  end
end
