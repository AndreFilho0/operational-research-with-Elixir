defmodule PesquisaOperacional.MatrixOperations do
  alias Nx, as: N

  def convert_to_matrix_restricoes(restricoes,index) do
    restricoes
    |> Enum.map(fn %{"coeficientes" => coef} -> coef end)
    |> Enum.map(fn row ->
      index
      |> Enum.map(fn index -> Enum.at(row, index) end)
    end)
    |> N.tensor()
  end
  def convert_to_matrix_b(restricoes) do
    restricoes
    |> Enum.map(fn %{"valor" => coef} -> coef end)
    |> N.tensor()
    |> Nx.reshape({2, 1})
  end
  def convert_to_matrix_gradiente(objetivo,index) do
    index
    |> Enum.map(fn index -> Enum.at(objetivo, index) end)
    |> N.tensor()

  end

  def invert_matrix(matrix) do
    try do
      {:ok , N.LinAlg.invert(matrix)}
    rescue
      _e in ArgumentError -> {:error, "Não foi possível inverter a matriz"}

    end

  end
  def tensor_to_map(tensor) do
    %{
      shape: Nx.shape(tensor),
      data: Nx.to_binary(tensor)
    }
  end

  def all_values_positive(tensor) do

    positive_mask = N.greater(tensor, 0)

    resultado = N.all(positive_mask)

    case N.to_number(resultado) do

      0 -> {:error , "tem valor menor ou igual a zero"}
      1 -> {:ok , "valor são maiores que zero"}
    end



  end

  def multiplicar_matrix(matrix1,matrix2) do
    # a ordem importa
     N.dot(matrix1, matrix2)

  end

  def inverter(restricoes, index) do

    matrix = convert_to_matrix_restricoes(restricoes,index)


    case invert_matrix(matrix) do
      {:ok, inv_matrix} ->
        {:ok , inv_matrix}

      error ->
        {:error , error}
    end
  end

  def calculoSolucao(base_inversa,b) do

   multiplicar_matrix(base_inversa,b)

  end

  def funcao_objetivo(gradiente,x) do
    multiplicar_matrix(gradiente,x)
    |> N.to_list()

  end
end
