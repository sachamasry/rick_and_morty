defmodule RickAndMortyWeb.CharacterLive.Show do
  use RickAndMortyWeb, :live_view

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
