defmodule RobotSimulator do
  defstruct direction: :north, position: {0, 0}

  @directions [:north, :east, :south, :west]

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0,0})

  def create(direction, _position) when direction not in @directions, do: {:error, "invalid direction"}

  def create(direction, {x, y} = position) when is_integer(x) and is_integer(y) do
    %RobotSimulator{position: position, direction: direction}
  end

  def create(_direction, _position), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    step(String.codepoints(instructions), robot)
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot),  do: robot.direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot), do: robot.position

  @spec step(list, robot :: any) :: robot :: any | {:error, String.t()}
  defp step([], robot), do: robot

  defp step(["L" | tail], robot) do
    case robot.direction do
      :north ->
        step(tail, Map.put(robot, :direction, :west))
      :west ->
        step(tail, Map.put(robot, :direction, :south))
      :south ->
        step(tail, Map.put(robot, :direction, :east))
      :east ->
        step(tail, Map.put(robot, :direction, :north))
    end
  end

  defp step(["R" | tail], robot) do
    case robot.direction do
      :north ->
        step(tail, Map.put(robot, :direction, :east))
      :east ->
        step(tail, Map.put(robot, :direction, :south))
      :south ->
        step(tail, Map.put(robot, :direction, :west))
      :west ->
        step(tail, Map.put(robot, :direction, :north))
    end
  end

  defp step(["A" | tail], %{position: {x, y}} = robot) do
    case robot.direction do
      :north ->
        step(tail, Map.put(robot, :position, {x, y + 1}))
      :east ->
        step(tail, Map.put(robot, :position, {x + 1, y}))
      :south ->
        step(tail, Map.put(robot, :position, {x, y - 1}))
      :west ->
        step(tail, Map.put(robot, :position, {x - 1, y}))
    end
  end

  defp step(_list, _robot) do
    {:error, "invalid instruction"}
  end
end
