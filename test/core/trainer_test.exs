defmodule Core.TrainerTest do
  use ExUnit.Case, async: true
  doctest(ElixirApiPokemon.Core.Trainer)

  alias ElixirApiPokemon.Core.Trainer

  describe "build/1" do
    test "should return a new trainer Maria with initial pokemon 1" do
      expected_response = %Trainer{
        name: "Maria Belizario",
        pokemons: %{0 => 1},
        number_pokemons: 1
      }

      assert Trainer.build("Maria Belizario", 1) == {:ok, expected_response}
    end

    test "should return a new trainer Camila with initial pokemon 4" do
      expected_response = %Trainer{
        name: "Camila maria",
        pokemons: %{0 => 4},
        number_pokemons: 1
      }

      assert Trainer.build("Camila maria", 4) == {:ok, expected_response}
    end

    test "should return a new trainer André with initial pokemon 7" do
      expected_response = %Trainer{
        name: "André Rodrigues",
        pokemons: %{0 => 7},
        number_pokemons: 1
      }

      assert Trainer.build("André Rodrigues", 7) == {:ok, expected_response}
    end

    test "should return an error when incorrect arguments is passed, and return trainer without changed" do
      assert Trainer.build("Camila maria", 10) == {:error, "not created"}
    end
  end

  describe "add_pokemon/2" do
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

  describe "remove_pokemon/2" do
    test "should return a trainer Maria with pokemons 4 and without 16" do
      trainer = %Trainer{
        name: "Maria Belizario",
        pokemons: %{0 => 4, 1 => 16},
        number_pokemons: 2
      }

      expected_response = %Trainer{
        name: "Maria Belizario",
        pokemons: %{0 => 4},
        number_pokemons: 1
      }

      assert Trainer.remove_pokemon(trainer, 1) == {:ok, expected_response}
    end

    test "should return a trainer Camila with pokemons 10 and without 25" do
      trainer = %Trainer{
        name: "Camila Maria",
        pokemons: %{0 => 10, 1 => 25},
        number_pokemons: 2
      }

      expected_response = %Trainer{
        name: "Camila Maria",
        pokemons: %{0 => 10},
        number_pokemons: 1
      }

      assert Trainer.remove_pokemon(trainer, 1) == {:ok, expected_response}
    end

    test "should return an error when incorrect arguments is passed, and return trainer without changed" do
      trainer = %Trainer{
        name: "Camila Maria",
        pokemons: %{0 => 10, 1 => 25},
        number_pokemons: 2
      }

      assert Trainer.remove_pokemon(trainer, "25") == {:error, trainer}
      assert Trainer.remove_pokemon(trainer, "error") == {:error, trainer}
    end
  end

  describe "change_order_pokemon/3" do
    test "should return a trainer Camila with pokemons 20 in first position" do
      trainer = %Trainer{
        name: "Camila Maria",
        pokemons: %{0 => 10, 1 => 20, 2 => 30},
        number_pokemons: 3
      }

      expected_response = %Trainer{
        name: "Camila Maria",
        pokemons: %{0 => 20, 1 => 10, 2 => 30},
        number_pokemons: 3
      }

      assert Trainer.change_order_pokemon(trainer, 1, 0) == {:ok, expected_response}
    end

    test "should return an error when incorrect arguments is passed, and return trainer without changed" do
      trainer = %Trainer{
        name: "Camila Maria",
        pokemons: %{0 => 10, 1 => 20, 2 => 30},
        number_pokemons: 3
      }

      assert Trainer.change_order_pokemon(trainer, 3, 0) == {:error, trainer}
    end
  end

  describe "get_random_trainer/1" do
    test "should return a random trainer with initial pokemon when argument with value 1 is passed" do
      {:ok, random_trainer} = Trainer.get_random_trainer(1)
      %struct_name{} = random_trainer
      number_pokemons = Map.get(random_trainer, :pokemons) |> Enum.count()

      assert struct_name == Trainer
      assert number_pokemons == 1
    end

    test "should return a random trainer with initial pokemon more 3 pokemons when argument with value 4 is passed" do
      {:ok, random_trainer} = Trainer.get_random_trainer(4)
      %struct_name{} = random_trainer
      number_pokemons = Map.get(random_trainer, :pokemons) |> Enum.count()

      assert struct_name == Trainer
      assert number_pokemons == 4
    end

    test "should return an error and random trainer with initial pokemon when argument with value 0 is passed" do
      {:error, random_trainer} = Trainer.get_random_trainer(0)
      %struct_name{} = random_trainer
      number_pokemons = Map.get(random_trainer, :pokemons) |> Enum.count()

      assert struct_name == Trainer
      assert number_pokemons == 1
    end

    test "should return an error and random trainer with initial pokemon when argument with value more than 6 is passed" do
      {:error, random_trainer} = Trainer.get_random_trainer(7)
      %struct_name{} = random_trainer
      number_pokemons = Map.get(random_trainer, :pokemons) |> Enum.count()

      assert struct_name == Trainer
      assert number_pokemons == 1
    end
  end
end
