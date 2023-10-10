import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rick_and_morty, RickAndMortyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "r6f4XMecTxK2cgNkQIF+9lGJlgh+WNNtFum2arhoGtqrx7rhPIbr6z+gyXk0mAwe",
  server: false

# In test we don't send emails.
config :rick_and_morty, RickAndMorty.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
