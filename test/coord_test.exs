defmodule CoordTest do
  use ExUnit.Case, async: true

  test "has x- and y-coordinates" do
    origin = %Coord{}
    assert 0 = origin.x
    assert 0 = origin.y
  end

  test "finds neighbors" do
    origin = %Coord{}
    points = [%Coord{x: -1, y: -1}, %Coord{x: -1, y: 0}, %Coord{x: -1, y: 1},
              %Coord{x:  0, y: -1},                      %Coord{x:  0, y: 1},
              %Coord{x:  1, y: -1}, %Coord{x:  1, y: 0}, %Coord{x:  1, y: 1}]
    expect = Enum.reduce(points, HashSet.new, fn(x, acc) -> Set.put(acc, x) end)
    assert Set.equal?(expect, Coord.neighbors(origin))
  end
end
