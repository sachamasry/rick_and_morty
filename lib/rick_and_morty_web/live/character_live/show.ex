defmodule RickAndMortyWeb.CharacterLive.Show do
  use RickAndMortyWeb, :live_view

  @impl true
  def mount(params, _session, socket) do
    page = String.to_integer(params["return_to_page"] || "1")
    name_filter = params["return_to_search"] || ""

    {:ok,
     socket
     |> assign(:page, page)
     |> assign(:name, name_filter)}
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
