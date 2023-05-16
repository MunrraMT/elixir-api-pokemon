defmodule ElixirApiPokemon.Api.PokeApi do
  @url_poke_api_base "https://pokeapi.co/api/v2/pokemon"
  @headers [{"Content-Type", "application/json"}]

  def get_kanto_pokemons() do
    %HTTPoison.Response{
      body: body_response
    } = HTTPoison.get!("#{@url_poke_api_base}?limit=150", @headers)

    %{"results" => results} = Jason.decode!(body_response)

    results
    |> Enum.map(fn %{"name" => name} -> name end)
    |> Enum.zip(0..149)
  end

  def get_pokemon_info(pokemon_number) do
    %HTTPoison.Response{
      body: body_response
    } = HTTPoison.get!("#{@url_poke_api_base}/#{pokemon_number}", @headers)

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
    } = Jason.decode!(body_response)

    %{
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
  end
end
