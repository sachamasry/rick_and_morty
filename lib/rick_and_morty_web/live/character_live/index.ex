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

    {:ok,
     socket
     |> assign(:page, page)
     |> assign(:next_page, next_page)
     |> assign(:previous_page, previous_page)
     |> assign(:name_filter, name_filter)
     |> stream(:characters, characters)}
  end

  def handle_event("name-search", %{"name" => name_filter}, socket) do
    send(self(), {:run_name_search, 1, name_filter})

    socket =
      assign(socket,
        page: 1,
        name_filter: name_filter,
        loading: true
      )

    {:noreply, socket}
  end

  def handle_info({:run_name_search, page, name_filter}, socket) do
    case RickAndMorty.API.get_characters(1, name_filter).results do
      [] ->
        socket =
          socket
          |> put_flash(:info, "No characters matching \"#{name_filter}\"")
          |> stream(:characters, [], reset: true)

        {:noreply, socket}

      _characters ->
        api_response = RickAndMorty.API.get_characters(1, name_filter)
        paging = api_response.info
        next_page = paging.next
        previous_page = paging.prev
        characters = api_response.results

        socket =
          socket
          |> clear_flash()
          |> assign(loading: false)
          |> assign(:page, page)
          |> assign(:next_page, next_page)
          |> assign(:previous_page, previous_page)
          |> assign(:name_filter, name_filter)
          |> stream(:characters, [], reset: true)
          |> stream(:characters, characters, reset: true)
        IO.inspect(socket.assigns.streams)

        {:noreply, socket}
    end
  end
end
