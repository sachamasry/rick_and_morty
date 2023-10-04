defmodule RickAndMortyWeb.CharacterLive.Index do
  use RickAndMortyWeb, :live_view

  @impl true
  def mount(params, _session, socket) do
    page = String.to_integer(params["page"] || "1")
    name_filter = params["name_filter"] || ""
    paging = RickAndMorty.API.get_characters(page).info
    next_page = paging.next
    previous_page = paging.prev

    {:ok,
     socket
     |> assign(:page, page)
     |> assign(:next_page, next_page)
     |> assign(:previous_page, previous_page)
     |> assign(:name_filter, "")
     |> stream(:characters, RickAndMorty.API.get_characters(page).results)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "1")
    name_filter = params["name_filter"] || ""
    paging = RickAndMorty.API.get_characters(page).info
    next_page = paging.next
    previous_page = paging.prev

    IO.inspect(paging)

    characters = RickAndMorty.API.get_characters(page).results

    {:noreply,
     # apply_action(socket, socket.assigns.live_action, params)}
     socket
     |> assign(:page_title, "All Characters")
     |> assign(:page, page)
     |> assign(:next_page, next_page)
     |> assign(:previous_page, previous_page)
     |> assign(:name_filter, "")
     |> assign(:characters, characters)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "All Characters")
    |> assign(:character, nil)
  end

  @impl true
  def handle_info({RickAndMortyWeb.CharacterLive.FormComponent, {:saved, product}}, socket) do
    {:noreply, stream_insert(socket, :products, product)}
  end

  # Code from PP exercises
  defp pagination_link(socket, text, page, name_filter, class) do
    live_patch(text,
      to:
      Routes.live_path(
        socket,
        __MODULE__,
        page: page,
        name_filter: name_filter
      ),
      class: class
    )
  end
end
