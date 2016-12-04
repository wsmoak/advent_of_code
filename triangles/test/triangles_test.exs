defmodule TrianglesTest do
  use ExUnit.Case
  doctest Triangles

  test "example 1" do
    input = "  810  679   10\n  783  255  616\n  545  626  626\n84  910  149\n  607  425  901\n  556  616  883"

    assert Triangles.count_valid(input) == 4
  end
end
