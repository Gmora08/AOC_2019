defmodule Aoc2019.Day2 do
  @doc """
  Process an intcode program, an intcode program is a list of integers

  ## Examples

    iex> Aoc2019.Day2.part1([1,0,0,0,99])
    [2,0,0,0,99]

    iex> Aoc2019.Day2.part1([2,3,0,3,99])
    [2,3,0,6,99]

    iex> Aoc2019.Day2.part1([2,4,4,5,99,0])
    [2,4,4,5,99,9801]

    iex> Aoc2019.Day2.part1([1,1,1,4,99,5,6,0,99])
    [30,1,1,4,2,5,6,0,99]

    iex> Aoc2019.Day2.part1([1,9,10,3,2,3,11,0,99,30,40,50])
    [3500,9,10,70,2,3,11,0,99,30,40,50]
  """
  @spec part1(list(integer)) :: list(integer)
  def part1(intcode) do
    intcode
    |> process_intcode(0)
  end

  def part2(intcode) do
    desired_input =
      for(noun <- 0..99, verb <- 0..99, do: %{noun: noun, verb: verb})    
      |> Enum.find(&find_desired_input(&1, intcode) == 19_690_720)

    100 * desired_input.noun + desired_input.verb
  end

  defp find_desired_input(desired_input, intcode) do
    executed_incode =
      intcode
      |> List.update_at(1, fn _ -> desired_input.noun end)
      |> List.update_at(2, fn _ -> desired_input.verb end)
      |> process_intcode(0)
    
    List.first(executed_incode)
  end

  @spec process_intcode(list(integer), integer) :: list(integer)
  defp process_intcode(intcode, opcode_index) do
    {opcode_value, _} = List.pop_at(intcode, opcode_index)
    cond do
      opcode_value == 99 ->
        intcode
      
      opcode_value == 1 || opcode_value == 2 ->
        intcode = transform_intcode(opcode_value, intcode, opcode_index)
        process_intcode(intcode, opcode_index + 4)
      
      true ->
        {:error, intcode}
    end
  end

  @spec transform_intcode(integer, list(integer), integer) :: list(integer)
  defp transform_intcode(1, intcode, opcode_index) do
    {first_argument, second_argument, index_element_to_replace} = get_intcode_to_transform(intcode, opcode_index)

    List.update_at(intcode, index_element_to_replace, fn _s -> first_argument + second_argument end)
  end

  @spec transform_intcode(integer, list(integer), integer) :: list(integer)
  defp transform_intcode(2, intcode, opcode_index) do
    {first_argument, second_argument, index_element_to_replace} = get_intcode_to_transform(intcode, opcode_index)

    List.update_at(intcode, index_element_to_replace, fn _s -> first_argument * second_argument end)
  end

  @spec get_intcode_to_transform(list(integer), integer) :: tuple
  defp get_intcode_to_transform(intcode, opcode_index) do
    {index_first_argument, _} = List.pop_at(intcode, opcode_index + 1)
    {index_second_argument, _} = List.pop_at(intcode, opcode_index + 2)
    {index_element_to_replace, _} = List.pop_at(intcode, opcode_index + 3)
    {first_argument, _} = List.pop_at(intcode, index_first_argument)
    {second_argument, _} = List.pop_at(intcode, index_second_argument)

    {first_argument, second_argument, index_element_to_replace}
  end
end
