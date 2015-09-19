defmodule Cell do
  defstruct live: false

  def lives_with_neighbors(%Cell{live: true}, neighbors) do
    case neighbors do
      3 -> true
      2 -> true
      _ -> false
    end
  end

  def lives_with_neighbors(%Cell{live: false}, neighbors) do
    case neighbors do
      3 -> true
      _ -> false
    end
  end
end
