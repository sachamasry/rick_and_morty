defmodule RickAndMortyWeb.CharacterLive.Index do
  use RickAndMortyWeb, :live_view

  @character_list [
    %RickAndMorty.Character{id: 13, avatar: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", name: "Bob", species: "Squirrel", status: "Live"},
    %RickAndMorty.Character{id: 69, avatar: "https://rickandmortyapi.com/api/character/avatar/2.jpeg", name: "Nicola", species: "Chipmunk", status: "Live"}
  ]

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :characters, @character_list)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "All Characters")
    |> assign(:product, nil)
  end

  @impl true
  def handle_info({RickAndMortyWeb.CharacterLive.FormComponent, {:saved, product}}, socket) do
    {:noreply, stream_insert(socket, :products, product)}
  end
end
