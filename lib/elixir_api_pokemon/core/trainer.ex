defmodule ElixirApiPokemon.Core.Trainer do
  defstruct [:name, pokemons: [], number_pokemons: 0]

  def new(%{name: name, initial_pokemon_id: initial_pokemon_id})
      when is_integer(initial_pokemon_id) do
    %__MODULE__{name: name}
    |> add_pokemon(initial_pokemon_id)
  end

  def add_pokemon(
        %__MODULE__{number_pokemons: number_pokemons, pokemons: current_pokemons} = trainer,
        pokemon_id
      )
      when is_integer(number_pokemons) and number_pokemons < 6 do
    new_trainer = %__MODULE__{
      trainer
      | number_pokemons: number_pokemons + 1,
        pokemons: current_pokemons ++ [pokemon_id]
    }

    {:ok, new_trainer}
  end

  def add_pokemon(%__MODULE__{} = trainer, _pokemon_id) do
    {:error, trainer}
  end

  def remove_pokemon(
        %__MODULE__{number_pokemons: number_pokemons, pokemons: current_pokemons} = trainer,
        pokemon_index
      )
      when is_integer(number_pokemons) and number_pokemons >= 2 and
             pokemon_index <= number_pokemons and pokemon_index > 1 do
    removed_pokemon_to_list =
      current_pokemons
      |> Map.delete(pokemon_index)
      |> Map.values()

    cleaned_trainer = %__MODULE__{trainer | number_pokemons: 0, pokemons: %{}}

    new_trainer =
      removed_pokemon_to_list
      |> Enum.reduce(cleaned_trainer, fn pokemon_id, cleaned_trainer ->
        {:ok, updated_trainer} = __MODULE__.add_pokemon(cleaned_trainer, pokemon_id)
        updated_trainer
      end)

    {:ok, new_trainer}
  end

  def remove_pokemon(%__MODULE__{} = trainer, _pokemon_id) do
    {:error, trainer}
  end
end
