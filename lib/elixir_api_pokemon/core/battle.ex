defmodule ElixirApiPokemon.Core.Battle do
  defstruct [:player, :player_pokemon, :computer, :computer_pokemon, :status]

  alias ElixirApiPokemon.Core.{Trainer, Pokemon}

  def build_wild_pokemon_battle(
        %Trainer{
          pokemons: %{0 => first_pokemon_id}
        } = trainer
      ) do
    {:ok, random_pokemon} = Pokemon.get_random_pokemon()
    {:ok, first_pokemon} = first_pokemon_id |> Pokemon.build()

    {:ok,
     %__MODULE__{
       player: trainer,
       player_pokemon: first_pokemon,
       computer_pokemon: random_pokemon,
       computer: random_pokemon,
       status: :started
     }}
  end

  def build_trainer_pokemon_battle(
        %Trainer{
          pokemons: %{0 => first_pokemon_id}
        } = trainer,
        computer_pokemons_number
      ) do
    {:ok,
     %Trainer{
       pokemons: %{0 => first_computer_pokemon_id}
     } = random_computer} =
      computer_pokemons_number
      |> Trainer.get_random_trainer()

    {:ok, first_computer_pokemon} = first_computer_pokemon_id |> Pokemon.build()
    {:ok, first_pokemon} = first_pokemon_id |> Pokemon.build()

    {:ok,
     %__MODULE__{
       player: trainer,
       player_pokemon: first_pokemon,
       computer_pokemon: first_computer_pokemon,
       computer: random_computer,
       status: :started
     }}
  end
end
