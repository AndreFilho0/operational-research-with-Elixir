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
    gradiente = MatrixOperations.convert_to_matrix_gradiente(params["objetivo"])
    IO.inspect(gradiente)
    {:ok ,base_inversa} = MatrixOperations.inverter(params["restricoes"])
    b = MatrixOperations.convert_to_matrix_b(params["restricoes"])
    x = MatrixOperations.calculoSolucao(base_inversa,b)
    case MatrixOperations.funcao_objetivo(gradiente,x) do

      {:ok,simplexs } ->
        put_status(conn,202)
        |> json(%{status: 202, data: simplexs})

        {:error,msg } ->
          put_status(conn,400)
          |> json(%{status: 400, data: msg})

    end

  end
end
