defmodule Core.BattleTest do
  use ExUnit.Case, async: true

  alias ElixirApiPokemon.Core.Pokemon
  alias ElixirApiPokemon.Core.Battle
  alias ElixirApiPokemon.Core.Trainer

  doctest(Battle)

  @trainer_test %Trainer{
    name: "Maria Belizario",
    pokemons: %{0 => 4, 1 => 0, 2 => 5},
    number_pokemons: 3
  }

  describe "build_wild_pokemon_battle/1" do
    test "should return initial Battle struct with the trainer's first pokemon passed by argument and one random wild pokemon" do
      {:ok, trainer_test_first_pokemon} =
        @trainer_test |> Map.get(:pokemons) |> Map.get(0) |> Pokemon.build()

      {:ok,
       %Battle{
         player: player,
         player_pokemon: player_pokemon,
         computer: %computer_struct{} = computer,
         computer_pokemon: computer_pokemon,
         status: status
       }} = Battle.build_wild_pokemon_battle(@trainer_test)

      assert player == @trainer_test
      assert player_pokemon == trainer_test_first_pokemon
      assert computer_struct == Pokemon
      assert computer == computer_pokemon
      assert status == :started
    end
  end
end
