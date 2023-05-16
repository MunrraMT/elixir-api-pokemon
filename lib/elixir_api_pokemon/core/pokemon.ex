defmodule ElixirApiPokemon.Core.Pokemon do
  defstruct [
    :id,
    :name,
    stats: %{
      life_points: nil,
      attack: nil,
      defense: nil,
      special_attack: nil,
      special_defense: nil,
      speed: nil
    }
  ]

  alias ElixirApiPokemon.Api.PokeApi

  def new(pokemon_id)
      when is_integer(pokemon_id) and pokemon_id > 0 and pokemon_id < 150 do
    %{
      "id" => id,
      "species" => %{"name" => name},
      "stats" => [
        %{"base_stat" => life_points_value},
        %{"base_stat" => attack_value},
        %{"base_stat" => defense_value},
        %{"base_stat" => special_attack_value},
        %{"base_stat" => special_defense_value},
        %{"base_stat" => speed_value}
      ]
    } = pokemon_id |> PokeApi.get_pokemon_info()

    new_pokemon = %__MODULE__{
      id: id,
      name: name,
      stats: %{
        life_points: life_points_value,
        attack: attack_value,
        defense: defense_value,
        special_attack: special_attack_value,
        special_defense: special_defense_value,
        speed: speed_value
      }
    }

    {:ok, new_pokemon}
  end

  def new(_pokemon_id) do
    {:error, "not created"}
  end

  def attack_strong(
        %__MODULE__{stats: %{attack: attack_value, special_attack: special_attack_value}} =
          _pokemon
      ) do
    attack = (attack_value + special_attack_value) / 2
    multiplier = 40..100 |> Enum.random()
    damage = (attack * (multiplier / 100)) |> round()
    precision = 10..70 |> Enum.random()

    {:ok, damage, precision}
  end

  def attack_weak(
        %__MODULE__{stats: %{attack: attack_value, special_attack: special_attack_value}} =
          _pokemon
      ) do
    attack = (attack_value + special_attack_value) / 2
    multiplier = 10..60 |> Enum.random()
    damage = (attack * (multiplier / 100)) |> round()
    precision = 40..100 |> Enum.random()

    {:ok, damage, precision}
  end

  def attack_buff(
        %__MODULE__{stats: %{attack: attack_value, special_attack: special_attack_value}} =
          pokemon
      ) do
    multiplier = (10..30 |> Enum.random()) + 100
    new_attack = (attack_value * (multiplier / 100)) |> round()
    new_special_attack = (special_attack_value * (multiplier / 100)) |> round()

    new_pokemon = %__MODULE__{
      pokemon
      | stats: %{attack: new_attack, special_attack: new_special_attack}
    }

    {:ok, new_pokemon}
  end
end
