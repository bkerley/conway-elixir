defmodule Board do
  defstruct live: HashSet.new

  def square() do
    members = Coord.array_to_coord_set([{0, 0},
                                        {0, 1},
                                        {1, 0},
                                        {1, 1}],
                                       HashSet.new)

    %Board{live: members}
  end

  def flipper() do
    members = Coord.array_to_coord_set([{1, 0},
                                        {1, 1},
                                        {1, 2}],
                                       HashSet.new)

    %Board{live: members}
  end

  def flopper() do
    members = Coord.array_to_coord_set([{0, 1},
                                        {1, 1},
                                        {2, 1}],
                                       HashSet.new
                                       )

    %Board{live: members}
  end

  def equal?(%Board{live: lhs}, %Board{live: rhs}) do
    HashSet.equal? lhs, rhs
  end

  def under_consideration(%Board{live: live}) do
    Enum.reduce(live, live, fn(live_cell, outer) ->
      Enum.reduce(Coord.neighbors(live_cell), outer, fn(neighbor, inner) ->
        Set.put(inner, neighbor)
      end)
    end)
  end

  def cell_at(%Board{live: live}, coord = %Coord{}) do
    %Cell{live: HashSet.member?(live, coord)}
  end

  def count_neighbors(%Board{live: live}, coord = %Coord{}) do
    coord
    |> Coord.neighbors
    |> Set.intersection(live)
    |> Set.size
  end

  def iterate(board = %Board{}) do
    board
    |> Board.under_consideration
    |> Set.to_list
    |> Enum.filter(fn(coord) ->
      cell = cell_at(board, coord)
      neighbors = count_neighbors(board, coord)
      Cell.lives_with_neighbors(cell, neighbors)
    end)
    |> Enum.reduce(HashSet.new, fn(coord, set) ->
      Set.put(set, coord)
    end)
    |> with_live_set
  end

  def with_live_set(set) do
    %Board{live: set}
  end
end
