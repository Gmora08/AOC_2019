defmodule Aoc2019.Utils do
  @folder "inputs"

  def extract_input(file) do
    @folder
    |> Path.join(file)
    |> File.stream!()
    |> Enum.map(fn line ->
      line
      |> String.split("\n", trim: true)
      |> List.first()
      |> String.to_integer(10)
    end)
  end
end