defmodule RickAndMorty.Repo do
  use Ecto.Repo,
    otp_app: :rick_and_morty,
    adapter: Ecto.Adapters.SQLite3
end
