defmodule RickAndMorty.API do
  @moduledoc """
  The `RickAndMorty.API` module is tasked only with interacting with the
  public Rick and Morty API service (https://rickandmortyapi.com/).
  """

  # Define the base URL and known endpoints
  @rick_and_morty_api_base_url "https://rickandmortyapi.com/api/"
  @character_list_endpoint_fragment "character"
  @single_character_endpoint_fragment "character"

  @doc"""
  Gets all the information on a single character with the unique ID of `id`.

  `id` can be a string or an integer; providing an empty string or anything else
  will result in an error.
  """
  def get_single_character(""), do: {:error, "Empty ID parameter supplied"}
  def get_single_character(id) do
    case Req.get(base_url: @rick_and_morty_api_base_url,
          url: @single_character_endpoint_fragment <> "/:id",
          path_params: [id: id],
          decode_json: [keys: :atoms]) do
      {:ok, %{body: body}} -> body
      {:error, message} -> {:error, message}
    end
  end

  @doc"""
  Gets full character list
  """
  def get_characters(page \\ 1, name_filter \\ "") do
    case Req.get(base_url: @rick_and_morty_api_base_url,
          url: @character_list_endpoint_fragment,
          params: [page: page, name: name_filter],
          decode_json: [keys: :atoms]) do
      {:ok, %{body:
               %{error: "There is nothing here"}}} ->
        %{results: [], info: %{count: 0, next: nil, prev: nil, pages: 1}}
      {:ok, %{body: body}} ->
        %{results:
          body.results
          |> Enum.map(fn (x) -> RickAndMorty.CharacterList.new(x) end),
          info: body.info}
      {:error, message} -> {:error, message}
    end
  end
end
