defmodule Core.TrainerTest do
  use ExUnit.Case
  doctest(ElixirApiPokemon.Core.Trainer)

  alias ElixirApiPokemon.Core.Trainer

  describe "ElixirApiPokemon.Core.Trainer.new/1" do
    test "should return a new trainer Maria with initial pokemon 4" do
      expected_response = %Trainer{
        name: "Maria Belizario",
        pokemons: %{0 => 4},
        number_pokemons: 1
      }

      assert Trainer.new(%{name: "Maria Belizario", initial_pokemon_id: 4}) ==
               {:ok, expected_response}
    end

    test "should return a new trainer Camila with initial pokemon 10" do
      expected_response = %Trainer{
        name: "Camila maria",
        pokemons: %{0 => 25},
        number_pokemons: 1
      }

      assert Trainer.new(%{name: "Camila maria", initial_pokemon_id: 25}) ==
               {:ok, expected_response}
    end
  end

  describe "ElixirApiPokemon.Core.Trainer.add_pokemon/2" do
    test "should return a trainer Maria with pokemons 4 and 16" do
      trainer = %Trainer{
        name: "Maria Belizario",
        pokemons: %{0 => 4},
        number_pokemons: 1
      }

      expected_response = %Trainer{
        name: "Maria Belizario",
        pokemons: %{0 => 4, 1 => 16},
        number_pokemons: 2
      }

      assert Trainer.add_pokemon(trainer, 16) == {:ok, expected_response}
    end

    test "should return a trainer Camila with pokemons 10 and 25" do
      trainer = %Trainer{
        name: "Camila Maria",
        pokemons: %{0 => 10},
        number_pokemons: 1
      }

      expected_response = %Trainer{
        name: "Camila Maria",
        pokemons: %{0 => 10, 1 => 25},
        number_pokemons: 2
      }

      assert Trainer.add_pokemon(trainer, 25) == {:ok, expected_response}
    end

    test "should return an error when incorrect arguments is passed, and return trainer without changed" do
      trainer = %Trainer{
        name: "Camila Maria",
        pokemons: %{0 => 10},
        number_pokemons: 1
      }

      assert Trainer.add_pokemon(trainer, "25") == {:error, trainer}
      assert Trainer.add_pokemon(trainer, "error") == {:error, trainer}
    end
  end

  describe "ElixirApiPokemon.Core.Trainer.remove_pokemon/2" do
    test "should return a trainer Maria with pokemons 4 and without 16" do
      trainer = %Trainer{
        name: "Maria Belizario",
        pokemons: [4, 16],
        number_pokemons: 2
      }

      expected_response = %Trainer{
        name: "Maria Belizario",
        pokemons: [4],
        number_pokemons: 1
      }

      assert Trainer.remove_pokemon(trainer, 16) == {:ok, expected_response}
    end

    test "should return a trainer Camila with pokemons 10 and without 25" do
      trainer = %Trainer{
        name: "Camila Maria",
        pokemons: [10, 25],
        number_pokemons: 2
      }

      expected_response = %Trainer{
        name: "Camila Maria",
        pokemons: [10],
        number_pokemons: 1
      }

      assert Trainer.remove_pokemon(trainer, 25) == {:ok, expected_response}
    end

    test "should return an error when pokemon id is not exist inside trainer, and return trainer without changed" do
      trainer = %Trainer{
        name: "Camila Maria",
        pokemons: [10, 20],
        number_pokemons: 2
      }

      assert Trainer.remove_pokemon(trainer, 30) == {:error, trainer}
    end

    test "should return an error when incorrect arguments is passed, and return trainer without changed" do
      trainer = %Trainer{
        name: "Camila Maria",
        pokemons: [10, 20],
        number_pokemons: 2
      }

      assert Trainer.remove_pokemon(trainer, "25") == {:error, trainer}
      assert Trainer.remove_pokemon(trainer, "error") == {:error, trainer}
    end
  end

  describe "ElixirApiPokemon.Core.Trainer.change_order_pokemon/3" do
    test "should return a trainer Camila with pokemons 20 in first position" do
      trainer = %Trainer{
        name: "Camila Maria",
        pokemons: [10, 20, 30],
        number_pokemons: 3
      }

      expected_response = %Trainer{
        name: "Camila Maria",
        pokemons: [20, 10, 30],
        number_pokemons: 3
      }

      assert Trainer.change_order_pokemon(trainer, 1, 0) == {:ok, expected_response}
    end
  end
end
