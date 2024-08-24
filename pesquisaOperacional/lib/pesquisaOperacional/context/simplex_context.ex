defmodule PesquisaOperacional.SimplexContext do
  alias PesquisaOperacional.Repository.SimplexApi
  alias PesquisaOperacional.Validate
  alias PesquisaOperacional.MatrixOperations
  alias Nx, as: N

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

  def solve(params) do
    numero_bases_possiveis =combinations(params["n"],params["m"])


    task1 = Task.async(fn -> calcular_funcao_objetivo(params,[0,1]) end)
    task2 = Task.async(fn -> calcular_funcao_objetivo(params,[0,2]) end)
    task3 = Task.async(fn -> calcular_funcao_objetivo(params,[0,3]) end)
    task4 = Task.async(fn -> calcular_funcao_objetivo(params,[1,2]) end)
    task5 = Task.async(fn -> calcular_funcao_objetivo(params,[1,3]) end)
    task6 = Task.async(fn -> calcular_funcao_objetivo(params,[2,3]) end)

    res1 = Task.await(task1)
    res2 = Task.await(task2)
    res3 = Task.await(task3)
    res4 = Task.await(task4)
    res5 = Task.await(task5)
    res6 = Task.await(task6)


    results = [res1, res2, res3, res4, res5, res6]

    maps_only = Enum.filter(results, &is_map/1)

    {:ok ,maps_only}



  end
  def calcular_funcao_objetivo(params,index) do
    gradiente = MatrixOperations.convert_to_matrix_gradiente(params["objetivo"],index)

    {:ok ,base_inversa} = MatrixOperations.inverter(params["restricoes"],index)
    b = MatrixOperations.convert_to_matrix_b(params["restricoes"])
    x = MatrixOperations.calculoSolucao(base_inversa,b)

   case MatrixOperations.all_values_positive(x) do
    {:ok , "valor são maiores que zero"} ->
      list = MatrixOperations.funcao_objetivo(gradiente, x) ++ N.to_list(x) ++ index
      tuple = List.to_tuple(list)
      map = %{
        resultado: elem(tuple, 0),
        xi: elem(tuple, 1),
        xj: elem(tuple, 2),
        i: elem(tuple, 3),
        j: elem(tuple, 4)
      }
    {:error , "tem valor menor ou igual a zero"} -> {:error , "tem valor menor ou igual a zero"}
   end

  end

  def factorial(n) when n == 0, do: 1
  def factorial(n) when n > 0 do
    Enum.reduce(1..n, 1, &(&1 * &2))
  end


  def combinations(n, m) when n >= m do
    factorial(n) / (factorial(m) * factorial(n - m))
  end

  def combinations(n,m) when  m > n do
    "error , numero de restrição maior que o de variaveis "
  end


end
