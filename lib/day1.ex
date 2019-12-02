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

  @spec get_fuel_required_for_mass(integer) :: integer
  defp get_fuel_required_for_mass(mass) do
    fuel = div(mass, 3)

    fuel - 2
  end
end