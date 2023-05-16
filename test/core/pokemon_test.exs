defmodule Core.PokemonTest do
  use ExUnit.Case
  alias ElixirApiPokemon.Core.Pokemon

  doctest(Pokemon)

  describe "new/1" do
    test "should return a new pokemon struct when pokemon_id 4 passed by arguments" do
      pokemon_test_id = 4
      {:ok, new_pokemon} = Pokemon.new(pokemon_test_id)

      assert Map.get(new_pokemon, :id) == pokemon_test_id
    end

    test "should return error if an incorrect argument passed" do
      assert Pokemon.new("pokemon_test_id") == {:error, "not created"}
    end
  end
end
