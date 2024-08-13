defmodule PesquisaOperacional.Simplex.Simplexdb do

  @moduledoc false

  use Ecto.Schema

  schema "simplex" do
    field :melhorsolucao, :string
    field :valorfuncaoobjetivo, :integer
    field :descricao, :string

    timestamps()
  end

end
