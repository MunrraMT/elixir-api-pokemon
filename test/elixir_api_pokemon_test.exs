defmodule ElixirApiPokemonTest do
  use ExUnit.Case
  doctest ElixirApiPokemon

  test "greets the world" do
    assert ElixirApiPokemon.hello() == :world
  end
end
