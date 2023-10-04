defmodule RickAndMortyWeb.CharacterLive.Index do
  use RickAndMortyWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :characters, RickAndMorty.API.get_characters().results)}
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
