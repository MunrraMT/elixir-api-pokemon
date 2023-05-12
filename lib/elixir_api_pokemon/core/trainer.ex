defmodule ElixirApiPokemon.Core.Trainer do
  defstruct [:name, pokemons: %{}, number_pokemons: 0]

  def new(%{name: name, initial_pokemon_id: initial_pokemon_id})
      when is_integer(initial_pokemon_id) do
    %__MODULE__{name: name}
    |> add_pokemon(initial_pokemon_id)
  end

  def add_pokemon(
        %__MODULE__{number_pokemons: number_pokemons, pokemons: current_pokemons} = trainer,
        pokemon_id
      )
      when is_integer(number_pokemons) and number_pokemons <= 5 do
    updated_number_pokemons = number_pokemons + 1
    updated_pokemon_list = current_pokemons |> Map.put(number_pokemons + 1, pokemon_id)

    new_trainer = %__MODULE__{
      trainer
      | number_pokemons: updated_number_pokemons,
        pokemons: updated_pokemon_list
    }

    {:ok, new_trainer}
  end

  def add_pokemon(%__MODULE__{} = trainer, _pokemon_id) do
    {:error, trainer}
  end
end
