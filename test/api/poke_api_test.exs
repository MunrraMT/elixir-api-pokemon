defmodule Api.PokeApiTest do
  use ExUnit.Case, async: true
  alias ElixirApiPokemon.Api.PokeApi

  doctest(PokeApi)

  @pokemon_test_id 4

  describe "get_kanto_pokemons/0" do
    test "should return a 150 first pokemons list" do
      assert Enum.count(PokeApi.get_kanto_pokemons()) == 150
    end
  end

  describe "get_pokemon_info/1" do
    test "should return pokemon info based on pokemon number passed by arguments" do
      %{"id" => id} = PokeApi.get_pokemon_info(@pokemon_test_id)

      assert id == @pokemon_test_id
    end
  end
end
