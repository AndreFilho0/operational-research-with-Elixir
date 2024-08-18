defmodule PesquisaOperacional.SimplexContext do
  alias PesquisaOperacional.Repository.SimplexApi
  alias PesquisaOperacional.Validate

  def all(_params) do
    case SimplexApi.all() do
      {:ok, simplex} -> {:ok, simplex |> Enum.map(& SimplexApi.json(&1, :public))}
      erro -> erro
    end
  end

  def get (params) do
    with {:ok , id} <- Validate.get_required(params,"id"),
         {:ok , value} <- Validate.is_inteiro(id),
         {:ok , simplex} <- SimplexApi.get(params["id"]) do

         {:ok , simplex |> SimplexApi.json(:public)}
    else
      erro -> erro
    end

  end
end
