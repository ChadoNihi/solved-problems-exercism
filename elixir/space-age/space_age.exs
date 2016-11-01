defmodule SpaceAge do
  @type planet :: :mercury | :venus | :earth | :mars | :jupiter
                | :saturn | :neptune | :uranus

  @doc """
  Return the number of years a person that has lived for 'seconds' seconds is
  aged on 'planet'.
  """
  @planetToSecPerY %{:mercury => 31557600 * 0.2408467,
                     :venus => 31557600 * 0.61519726,
                     :earth => 31557600,
                     :mars => 31557600 * 1.8808158,
                     :jupiter => 31557600 * 11.862615,
                     :saturn => 31557600 * 29.447498,
                     :neptune => 31557600 * 164.79132,
                     :uranus => 31557600 * 84.016846}

  @spec age_on(planet, pos_integer) :: float
  def age_on(planet, seconds) do
    seconds / Map.get(@planetToSecPerY, planet)
  end
end
