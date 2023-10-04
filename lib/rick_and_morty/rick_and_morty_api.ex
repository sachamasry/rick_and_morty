defmodule RickAndMorty.API do
  @moduledoc """
  The `RickAndMorty.API` module is tasked only with interacting with the
  public Rick and Morty API service (https://rickandmortyapi.com/).
  """

  @rick_and_morty_api_base_url "https://rickandmortyapi.com/api/"
  @character_list_endpoint_fragment "character"
  @single_character_endpoint_fragment "character"

  @doc"""
  Gets all the information on a single character with the unique ID of `id`

  `id` can be a string or an integer; providing an empty string or anything else
  will result in an error.
  """
  def get_single_character(id) do
    case Req.get(base_url: @rick_and_morty_api_base_url,
          url: @single_character_endpoint_fragment <> "/:id",
          path_params: [id: id],
          decode_json: [keys: :atoms!]) do
      {:ok, %{body: body}} -> body
      {:error, message} -> {:error, message}
    end
  end

  def get_single_character(""), do: {:error, "Empty ID parameter supplied"}
  def get_single_character(_id), do: {:error, "Incorrect or empty ID parameter supplied"}
end
