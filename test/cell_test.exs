defmodule CellTest do
  use ExUnit.Case, async: true

  test "lives with 3 neighbors" do
    assert Cell.lives_with_neighbors %Cell{live: true}, 3
    assert Cell.lives_with_neighbors %Cell{}, 3
  end

  test "remains alive with 2 neighbors" do
    assert Cell.lives_with_neighbors %Cell{live: true}, 2
    refute Cell.lives_with_neighbors %Cell{}, 2
  end
end
