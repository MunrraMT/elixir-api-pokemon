defmodule Core.PokemonTest do
  use ExUnit.Case
  alias ElixirApiPokemon.Core.Pokemon

  doctest(Pokemon)

  @pokemon_test_id 4

  describe "new/1" do
    test "should return a new pokemon struct when pokemon_id 4 passed by argument" do
      {:ok, new_pokemon} = Pokemon.new(@pokemon_test_id)

      assert Map.get(new_pokemon, :id) == @pokemon_test_id
    end

    test "should return error if an incorrect argument passed" do
      assert Pokemon.new("pokemon_test_id") == {:error, "not created"}
    end
  end

  describe "attack_strong/1" do
    test "should return damage and precision value if pokemon struct passed by argument" do
      {:ok,
       %Pokemon{
         stats: %{
           attack: attack_value,
           special_attack: special_attack_value
         }
       } = new_pokemon} = Pokemon.new(@pokemon_test_id)

      min_damage = round((attack_value + special_attack_value) / 2 * (40 / 100))
      min_precision = 10

      {:ok, damage, precision} = Pokemon.attack_strong(new_pokemon)

      assert damage >= min_damage
      assert precision >= min_precision
    end
  end
end
