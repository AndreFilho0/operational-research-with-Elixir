defmodule PesquisaOperacional.SimplexContext do

  alias PesquisaOperacional.Repository.SimplexApi

  def all(_params) do

    SimplexApi.all()
    |> Enum.map(& SimplexApi.json(&1, :public))

  end





end
