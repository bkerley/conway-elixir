defmodule BoardTest do
  use ExUnit.Case, async: true

  test "iterates an empty board" do
    empty = %Board{}
    assert Board.iterate(empty) == empty
  end

  test "iterates a square" do
    square = Board.square()
    iterated = Board.iterate(square)
    assert Board.iterate(square) == square
  end

  test "iterates the flipper" do
    flipper = Board.flipper()
    flopper = Board.flopper()

    assert Board.equal?(Board.iterate(flipper), flopper)
    assert Board.equal?(Board.iterate(flopper), flipper)
  end

  test "finds cells under consideration on an empty board" do
    assert HashSet.new == Board.under_consideration(%Board{})
  end

  test "finds cells under consideration on a square board" do
    expected = Coord.array_to_coord_set(
      [{-1, -1}, {-1, 0}, {-1, 1}, {-1, 2},
       { 0, -1}, { 0, 0}, { 0, 1}, { 0, 2},
       { 1, -1}, { 1, 0}, { 1, 1}, { 1, 2},
       { 2, -1}, { 2, 0}, { 2, 1}, { 2, 2}],
      HashSet.new)

    assert HashSet.equal? expected, Board.under_consideration(Board.square)
  end

  test "finds cells at a position" do
    assert %Cell{live: true} == Board.cell_at(Board.square, %Coord{})
    assert %Cell{live: false} == Board.cell_at(%Board{}, %Coord{})
  end

  test "counts neighbor cells" do
    assert 0 == Board.count_neighbors(%Board{}, %Coord{})
    assert 3 == Board.count_neighbors(Board.square, %Coord{})
  end
end
