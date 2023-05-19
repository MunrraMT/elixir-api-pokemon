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

  @trainer_test_first_pokemon %ElixirApiPokemon.Core.Pokemon{
    id: 4,
    name: "charmander",
    stats: %{
      attack: 52,
      defense: 43,
      life_points: 39,
      special_attack: 60,
      special_defense: 50,
      speed: 65
    }
  }

  describe "build_wild_pokemon_battle/1" do
    test "should return initial Battle struct with the trainer's first pokemon passed by argument and one random wild pokemon" do
      {:ok,
       %Battle{
         player: player,
         player_pokemon: player_pokemon,
         computer: %computer_struct{} = computer,
         computer_pokemon: computer_pokemon,
         status: status
       }} = Battle.build_wild_pokemon_battle(@trainer_test)

      assert player == @trainer_test
      assert player_pokemon == @trainer_test_first_pokemon
      assert computer_struct == Pokemon
      assert computer == computer_pokemon
      assert status == :started
    end
  end

  describe "build_trainer_pokemon_battle/2" do
    test "should return initial Battle struct with the trainer's first pokemon passed by argument and random computer trainer with your first pokemon and other 3 pokemons" do
      {:ok,
       %Battle{
         player: player,
         player_pokemon: player_pokemon,
         computer: %computer_struct{number_pokemons: computer_number_pokemons} = _computer,
         computer_pokemon: %computer_pokemon_struct{} = _computer_pokemon,
         status: status
       }} = Battle.build_trainer_pokemon_battle(@trainer_test, 4)

      assert player == @trainer_test
      assert player_pokemon == @trainer_test_first_pokemon
      assert computer_struct == Trainer
      assert computer_pokemon_struct == Pokemon
      assert status == :started
      assert computer_number_pokemons == 4
    end

    test "should return initial Battle struct with the trainer's first pokemon passed by argument and random computer trainer with your first pokemon and other 5 pokemons" do
      {:ok,
       %Battle{
         player: player,
         player_pokemon: player_pokemon,
         computer: %computer_struct{number_pokemons: computer_number_pokemons} = _computer,
         computer_pokemon: %computer_pokemon_struct{} = _computer_pokemon,
         status: status
       }} = Battle.build_trainer_pokemon_battle(@trainer_test, 6)

      assert player == @trainer_test
      assert player_pokemon == @trainer_test_first_pokemon
      assert computer_struct == Trainer
      assert computer_pokemon_struct == Pokemon
      assert status == :started
      assert computer_number_pokemons == 6
    end
  end
end
