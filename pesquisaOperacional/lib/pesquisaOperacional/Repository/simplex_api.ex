defmodule PesquisaOperacional.Repository.SimplexApi do


   alias PesquisaOperacional.Repo
   alias PesquisaOperacional.Simplex.Simplexdto

   import Ecto.Query

  def all do
    Repo.all(Simplexdto)

  end

  def get(id) do
    Repo.get(Simplexdto,id)
  end

  def get_by(where) do
    from(Simplexdto)
    |> where(^where)
    |> Repo.one()

  end

  def delete(id) do
    case get(id) do
      nil -> nil
      simplexdto -> Repo.delete(simplexdto)
    end
  end

  def insert(parms) do
    %Simplexdto{}
    |> Simplexdto.changeset(parms)
    |> Repo.insert()
  end

  def update(model , params) do

    model
    |> Simplexdto.changeset(params)
    |> Repo.update()
  end

  def json(model ,permission) do
    Map.take(model,Simplexdto.permission(permission))
  end


end
