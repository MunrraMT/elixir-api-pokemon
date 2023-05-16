defmodule Api.PokeApiTest do
  use ExUnit.Case, async: true
  alias ElixirApiPokemon.Api.PokeApi

  doctest(PokeApi)

  describe "get_kanto_pokemons/0" do
    test "should return a 150 first pokemons list" do
      assert length(PokeApi.get_kanto_pokemons()) == 150
    end
  end
end
