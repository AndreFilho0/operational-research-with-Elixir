defmodule PesquisaOperacional.Repo do
  use Ecto.Repo,
    otp_app: :pesquisaOperacional,
    adapter: Ecto.Adapters.Postgres
end
