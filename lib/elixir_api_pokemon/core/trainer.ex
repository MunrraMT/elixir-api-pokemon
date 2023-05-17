defmodule ElixirApiPokemon.Core.Trainer do
  defstruct [:name, pokemons: %{}, number_pokemons: 0]

  def build(name, initial_pokemon_id)
      when is_integer(initial_pokemon_id) and
             (initial_pokemon_id == 0 or
                initial_pokemon_id == 3 or
                initial_pokemon_id == 6) do
    %__MODULE__{name: name} |> add_pokemon(initial_pokemon_id)
  end

  def build(_name, _pokemon_id) do
    {:error, "not created"}
  end

  def add_pokemon(
        %__MODULE__{number_pokemons: number_pokemons, pokemons: current_pokemons} = trainer,
        pokemon_id
      )
      when number_pokemons < 6 and is_integer(pokemon_id) do
    new_trainer = %__MODULE__{
      trainer
      | pokemons: Map.put(current_pokemons, number_pokemons, pokemon_id),
        number_pokemons: number_pokemons + 1
    }

    {:ok, new_trainer}
  end

  def add_pokemon(%__MODULE__{} = trainer, _pokemon_id) do
    {:error, trainer}
  end

  def remove_pokemon(
        %__MODULE__{number_pokemons: number_pokemons, pokemons: current_pokemons} = trainer,
        pokemon_target_index
      )
      when number_pokemons > 1 and
             is_integer(pokemon_target_index) and
             pokemon_target_index < number_pokemons do
    pokemon_filtered_list =
      current_pokemons
      |> Map.delete(pokemon_target_index)
      |> Map.values()

    new_pokemon_list =
      0..(number_pokemons - 1)
      |> Enum.zip(pokemon_filtered_list)
      |> Enum.into(%{})

    new_trainer = %__MODULE__{
      trainer
      | number_pokemons: number_pokemons - 1,
        pokemons: new_pokemon_list
    }

    {:ok, new_trainer}
  end

  def remove_pokemon(%__MODULE__{} = trainer, _pokemon_id) do
    {:error, trainer}
  end

  def change_order_pokemon(
        %__MODULE__{number_pokemons: number_pokemons, pokemons: current_pokemons} = trainer,
        pokemon_origem_index,
        pokemon_target_index
      )
      when number_pokemons > 1 and
             is_integer(pokemon_origem_index) and
             pokemon_origem_index >= 0 and
             pokemon_origem_index < number_pokemons and
             is_integer(pokemon_target_index) and
             pokemon_target_index >= 0 and
             pokemon_target_index < number_pokemons do
    pokemon_origem = Map.get(current_pokemons, pokemon_origem_index)
    pokemon_target = Map.get(current_pokemons, pokemon_target_index)

    new_pokemon_list =
      current_pokemons
      |> Map.replace(pokemon_target_index, pokemon_origem)
      |> Map.replace(pokemon_origem_index, pokemon_target)

    new_trainer = %__MODULE__{
      trainer
      | pokemons: new_pokemon_list
    }

    {:ok, new_trainer}
  end

  def change_order_pokemon(
        %__MODULE__{} = trainer,
        _pokemon_origem_index,
        _pokemon_target_index
      ) do
    {:error, trainer}
  end

  def get_random_trainer(1) do
    random_initial_pokemon = [0, 3, 6] |> Enum.random()

    __MODULE__.build("random_trainer", random_initial_pokemon)
  end

  def get_random_trainer(number_pokemons)
      when is_integer(number_pokemons) and number_pokemons >= 2 and number_pokemons <= 6 do
    {:ok, random_trainer} = __MODULE__.get_random_trainer(1)

    trainer_with_pokemons =
      2..number_pokemons
      |> Enum.reduce(random_trainer, fn _number, random_trainer ->
        pokemon_id = 0..149 |> Enum.random()
        {:ok, new_trainer} = __MODULE__.add_pokemon(random_trainer, pokemon_id)

        new_trainer
      end)

    {:ok, trainer_with_pokemons}
  end

  def get_random_trainer(_number_pokemons) do
    {:ok, random_trainer} = __MODULE__.get_random_trainer(1)
    {:error, random_trainer}
  end
end
