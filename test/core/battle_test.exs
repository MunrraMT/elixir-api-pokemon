defmodule Core.BattleTest do
  use ExUnit.Case, async: true

  alias ElixirApiPokemon.Core.{Pokemon, Battle, Trainer}

  doctest(Battle)

  @trainer_test %Trainer{
    name: "Maria Belizario",
    pokemons: %{0 => 4, 1 => 1, 2 => 5},
    number_pokemons: 3
  }

  @trainer_battle_test %Trainer{
    name: "Maria Belizario",
    pokemons: %{
      0 => %ElixirApiPokemon.Core.Pokemon{
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
      },
      1 => %ElixirApiPokemon.Core.Pokemon{
        id: 1,
        name: "bulbasaur",
        stats: %{
          attack: 49,
          defense: 49,
          life_points: 45,
          special_attack: 65,
          special_defense: 65,
          speed: 45
        }
      },
      2 => %ElixirApiPokemon.Core.Pokemon{
        id: 5,
        name: "charmeleon",
        stats: %{
          attack: 64,
          defense: 58,
          life_points: 58,
          special_attack: 80,
          special_defense: 65,
          speed: 80
        }
      }
    },
    number_pokemons: 3
  }

  describe "build/2" do
    test "should returns battle struct if recebe player trainer and computer trainer valid arguments" do
      {:ok, player_trainer} = Trainer.build("Maria Belizario", 1)
      {:ok, computer_trainer} = Trainer.get_random_trainer(1)

      {:ok,
       %battle_struct_name{
         player: player_trainer_battle,
         computer: computer_trainer_battle
       } = _battle_struct} = Battle.build(player_trainer, computer_trainer)

      assert battle_struct_name == Battle
      assert player_trainer_battle.name == player_trainer.name
      assert computer_trainer_battle.name == computer_trainer.name
    end
  end
end
