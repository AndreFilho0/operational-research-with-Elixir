defmodule PesquisaOperacional.Simplex.Simplexdto do

  @moduledoc false

  use Ecto.Schema

  schema "simplex" do
    field :melhorsolucao, :string
    field :valorfuncaoobjetivo, :integer
    field :descricao, :string

    timestamps()
  end

  def changeset(model , params) do
    model
    |> Ecto.Changeset.cast(params,[:melhorsolucao,:valorfuncaoobjetivo])
    |> Ecto.Changeset.validate_required([:melhorsolucao,:valorfuncaoobjetivo])

  end
  

end
