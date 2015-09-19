defmodule Coord do
  defstruct x: 0, y: 0

  def neighbors(coord = %Coord{x: x, y: y}) do
    Enum.reduce([x - 1, x, x + 1], HashSet.new, fn(x, row_neighbors) ->
      Enum.reduce([y - 1, y, y + 1], row_neighbors, fn(y, col_neighbors) ->
        Set.put(col_neighbors, %Coord{x: x, y: y})
      end)
    end)
    |> Set.delete(coord)
  end

  def array_to_coord_set([], coll = %HashSet{}) do
    coll
  end
  def array_to_coord_set([{x, y} | rest], coll = %HashSet{}) do
    array_to_coord_set(rest, Set.put(coll, %Coord{x: x, y: y}))
  end
end
