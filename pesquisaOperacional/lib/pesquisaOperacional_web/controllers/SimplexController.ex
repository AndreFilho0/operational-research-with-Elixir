defmodule PesquisaOperacionalWeb.SimplexController do
 use PesquisaOperacionalWeb, :controller

 alias PesquisaOperacional.SimplexContext
 alias PesquisaOperacional.MatrixOperations
  def all(conn,params) do
    case SimplexContext.all(params) do

      {:ok,simplexs } ->
        put_status(conn,202)
        |> json(%{status: 202, data: simplexs})

        {:erro,msg } ->
          put_status(conn,400)
          |> json(%{status: 400, data: msg})
    end

  end

  def get(conn,params) do
    case SimplexContext.get(params) do

      {:ok,simplexs } ->
        put_status(conn,202)
        |> json(%{status: 202, data: simplexs})

        {:erro,msg } ->
          put_status(conn,400)
          |> json(%{status: 400, data: msg})

    end
  end

  def solve(conn,params) do

    case SimplexContext.solve(params) do

      {:ok, results} when is_list(results) ->
        put_status(conn,200)
        |> json(%{status: 200, data: results})

        {:error,msg } ->
          put_status(conn,400)
          |> json(%{status: 400, data: msg})

    end

  end
end
