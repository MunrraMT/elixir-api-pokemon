defmodule ElixirApiPokemon.Api.PokeApi do
  @url_poke_api_base "https://pokeapi.co/api/v2/pokemon"
  @headers [{"Content-Type", "application/json"}]

  def get_kanto_pokemons() do
    %HTTPoison.Response{
      body: body_response
    } = HTTPoison.get!("#{@url_poke_api_base}?limit=150", @headers)

    %{"results" => results} = Jason.decode!(body_response)
    pokemons_name = results |> Enum.map(fn %{"name" => name} -> name end)

    0..149 |> Enum.zip(pokemons_name) |> Enum.into(%{})
  end

  def get_pokemon_info(pokemon_id) do
    %HTTPoison.Response{
      body: body_response
    } = HTTPoison.get!("#{@url_poke_api_base}/#{pokemon_id}", @headers)

    Jason.decode!(body_response)
  end
end
