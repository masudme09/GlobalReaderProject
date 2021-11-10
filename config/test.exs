use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :global_reader_project, GlobalReaderProject.Repo,
  username: "postgres",
  password: "postgres",
  database: "global_reader_project_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :global_reader_project, GlobalReaderProjectWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn
config :hound, driver: "chrome_driver"
config :global_reader_project, sql_sandbox: true
