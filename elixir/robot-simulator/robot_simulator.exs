defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: { integer, integer }) :: any
  def create(direction \\ :north, position \\ {0,0}) do
    cond do
      !(direction in [:north, :east, :south, :west]) ->
        { :error, "invalid direction" }
      ! is_tuple(position) or tuple_size(position) != 2 or ! is_number(elem(position, 0)) or ! is_number(elem(position, 1)) ->
        { :error, "invalid position" }
      true ->
        %{direction: direction, position: position}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t ) :: any
  def simulate(robot, instructions) do
    if Regex.match?(~r/^[RLA]*$/, instructions) do
      String.split(instructions, "", trim: true)
      |> Enum.reduce(robot, fn(action, robot) -> perform_action(robot, action) end)
    else
      { :error, "invalid instruction" }
    end
  end

  defp perform_action(robot, action) do
    case action do
      "R" ->
        Map.update!(robot, :direction, &(right_dir_from(&1)))
      "L" ->
        Map.update!(robot, :direction, &(left_dir_from(&1)))
      "A" ->
        Map.update!(robot, :position, &(advance_pos_from(&1, robot.direction)))
    end
  end

  defp right_dir_from(dir) do
    case dir do
      :north -> :east
      :east -> :south
      :south -> :west
      :west -> :north
    end
  end

  defp left_dir_from(dir) do
    case dir do
      :north -> :west
      :west -> :south
      :south -> :east
      :east -> :north
    end
  end

  defp advance_pos_from({x,y}, dir) do
    case dir do
      :north -> {x, y+1}
      :east -> {x+1, y}
      :south -> {x, y-1}
      :west -> {x-1, y}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    Map.get(robot, :direction)
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: { integer, integer }
  def position(robot) do
    Map.get(robot, :position)
  end
end
