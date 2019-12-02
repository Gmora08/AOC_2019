defmodule Aoc2019.Day1 do
  @doc """
  Calculates the fuel required for a list of masses?

  ## Examples

    iex> Aoc2019.Day1.part1([1969])
    654

    iex> Aoc2019.Day1.part1([100756])
    33583
  """
  @spec part1(list(integer)) :: integer
  def part1(mass_list) do
    Enum.reduce(mass_list, 0, fn mass, acc ->
      fuel = get_fuel_required_for_mass(mass)
      acc + fuel
    end)
  end

  @doc """
  Calculates the cost of take a module

  ## Examples

    iex> Aoc2019.Day1.part2([1969])
    966

    iex> Aoc2019.Day1.part2([100756])
    50346
  """
  def part2(mass_list) do
    mass_list
    |> Enum.map(&get_fuel_required_for_mass/1)
    |> Enum.map(fn module_fuel ->
      get_fuel_required_for_module(module_fuel, 0) + module_fuel
    end)
    |> Enum.sum()
  end

  @spec get_fuel_required_for_mass(integer) :: integer
  defp get_fuel_required_for_mass(mass) do
    fuel = div(mass, 3)

    fuel - 2
  end

  @spec get_fuel_required_for_module(integer, integer) :: integer
  defp get_fuel_required_for_module(mass, acc) do
    fuel_required = get_fuel_required_for_mass(mass)

    if fuel_required <= 0 do
      acc
    else
      get_fuel_required_for_module(fuel_required, acc + fuel_required)
    end
  end
end