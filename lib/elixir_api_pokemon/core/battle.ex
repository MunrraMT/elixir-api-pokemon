defmodule ElixirApiPokemon.Core.Battle do
  defstruct [:player, :player_pokemon, :computer, :computer_pokemon, :turn, :status]

  alias ElixirApiPokemon.Core.{Trainer, Pokemon}

  def build(
        %Trainer{pokemons: trainer_pokemon_list} = player_trainer,
        %Trainer{pokemons: computer_pokemon_list} = computer_trainer
      ) do
    player_pokemon_builded_list = build_pokemon_list(trainer_pokemon_list)
    computer_pokemon_builded_list = build_pokemon_list(computer_pokemon_list)

    {:ok,
     %__MODULE__{
       player: %Trainer{player_trainer | pokemons: player_pokemon_builded_list},
       player_pokemon: Map.get(player_pokemon_builded_list, 0),
       computer: %Trainer{computer_trainer | pokemons: computer_pokemon_builded_list},
       computer_pokemon: Map.get(computer_pokemon_builded_list, 0),
       turn: :player,
       status: :started
     }}
  end

  def build(%Trainer{pokemons: trainer_pokemon_list} = player_trainer, %Pokemon{} = wild_pokemon) do
    player_pokemon_builded_list = build_pokemon_list(trainer_pokemon_list)

    {:ok,
     %__MODULE__{
       player: %Trainer{player_trainer | pokemons: player_pokemon_builded_list},
       player_pokemon: Map.get(player_pokemon_builded_list, 0),
       computer: wild_pokemon,
       computer_pokemon: wild_pokemon,
       turn: :player,
       status: :started
     }}
  end

  def attack_movement(
        %__MODULE__{
          player_pokemon: player_pokemon,
          computer_pokemon: computer_pokemon,
          turn: :player
        } = _status,
        movement_name
      ) do
    {pokemon_origin, pokemon_target} = attack(player_pokemon, computer_pokemon, movement_name)

    {:ok,
     %__MODULE__{
       player_pokemon: pokemon_origin,
       computer_pokemon: pokemon_target,
       turn: change_turn(:player),
       status: :during
     }}
  end

  def attack_movement(
        %__MODULE__{
          player_pokemon: player_pokemon,
          computer_pokemon: computer_pokemon,
          turn: :computer
        } = _status,
        movement_name
      ) do
    {pokemon_origin, pokemon_target} = attack(player_pokemon, computer_pokemon, movement_name)

    {:ok,
     %__MODULE__{
       player_pokemon: pokemon_target,
       computer_pokemon: pokemon_origin,
       turn: change_turn(:computer),
       status: :during
     }}
  end

  defp build_pokemon_list(pokemon_list) do
    pokemon_builded_list =
      pokemon_list
      |> Enum.map(fn {_key, value} ->
        {:ok, pokemon_builded} = Pokemon.build(value)
        pokemon_builded
      end)

    pokemon_builded_list_formatted =
      0..(length(pokemon_builded_list) - 1)
      |> Enum.zip(pokemon_builded_list)
      |> Enum.into(%{})

    pokemon_builded_list_formatted
  end

  defp attack(pokemon_origin, pokemon_target, :attack_strong) do
    {:ok, damage, precision} = Pokemon.attack_strong(pokemon_origin)
    pokemon_attacked_result = attack_result(damage, precision, pokemon_target)
    {pokemon_origin, pokemon_attacked_result}
  end

  defp attack(pokemon_origin, pokemon_target, :attack_weak) do
    {:ok, damage, precision} = Pokemon.attack_weak(pokemon_origin)
    pokemon_attacked_result = attack_result(damage, precision, pokemon_target)
    {pokemon_origin, pokemon_attacked_result}
  end

  defp attack_result(damage, precision, pokemon_target)
       when is_integer(precision) and precision >= 50 do
    {:ok, pokemon_target_with_new_life_point} = Pokemon.recebe_damage(damage, pokemon_target)
    pokemon_target_with_new_life_point
  end

  defp attack_result(_damage, precision, pokemon_target)
       when is_integer(precision) and precision < 50 do
    pokemon_target
  end

  defp change_turn(:player), do: :computer
  defp change_turn(:computer), do: :player
end
