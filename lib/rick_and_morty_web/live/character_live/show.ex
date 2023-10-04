defmodule RickAndMortyWeb.CharacterLive.Show do
  use RickAndMortyWeb, :live_view

  @character %{
    id: 13,
    name: "Alien Googah",
    status: "unknown",
    type: "",
    origin: %{origin_name: "unknown", origin_url: ""},
    location: %{
      location_url: "https://rickandmortyapi.com/api/location/20",
      location_name: "Earth (Replacement Dimension)"
    },
    url: "https://rickandmortyapi.com/api/character/13",
    species: "Alien",
    avatar: "https://rickandmortyapi.com/api/character/avatar/13.jpeg",
    gender: "unknown",
    created: "2017-11-04T20:33:30.779Z",
    episode: ["https://rickandmortyapi.com/api/episode/31"]
  }

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:character, RickAndMorty.API.get_single_character(id))}
  end

  defp page_title(:show), do: "Show Character"
end
