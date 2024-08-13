defmodule PesquisaOperacional.Repo.Migrations.CreateTableSimplex do
  use Ecto.Migration

  def change do
    create table("simplex") do
      add :melhorsolucao, :string
      add :valorfuncaoobjetivo, :integer
      add :descricao, :string
    end

  end
end
