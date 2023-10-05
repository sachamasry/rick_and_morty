defmodule RickAndMortyWeb.CharacterLive.Index do
  use RickAndMortyWeb, :live_view

  @impl true
  def mount(params, _session, socket) do
    page = String.to_integer(params["page"] || "1")
    name_filter = params["name"] || ""
    api_response = RickAndMorty.API.get_characters(page, name_filter)
    paging = api_response.info
    next_page = paging.next
    previous_page = paging.prev
    characters = api_response.results

    IO.puts next_page

    {:ok,
     socket
     |> assign(:page, page)
     |> assign(:next_page, next_page)
     |> assign(:previous_page, previous_page)
     |> assign(:name_filter, name_filter)
     |> stream(:characters, characters)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "1")
    name_filter = params["name"] || ""
    api_response = RickAndMorty.API.get_characters(page, name_filter)
    paging = api_response.info
    next_page = paging.next
    previous_page = paging.prev
    characters = api_response.results

    {:noreply,
     # apply_action(socket, socket.assigns.live_action, params)}
     socket
     |> assign(:page_title, "All Characters")
     |> assign(:page, page)
     |> assign(:next_page, next_page)
     |> assign(:previous_page, previous_page)
     |> assign(:name_filter, name_filter)
     |> assign(:characters, characters)}
  end

  @impl true
  def handle_info({RickAndMortyWeb.CharacterLive.FormComponent, {:saved, product}}, socket) do
    {:noreply, stream_insert(socket, :products, product)}
  end
end
