defmodule PesquisaOperacional.Validate do

  def get_required(params,field) do
    case params[field] do
      nil -> {:erro , "o campo `#{field}` não existe"}
      sucesso -> {:ok ,sucesso}
    end
  end

  def is_inteiro(value) do
     case Integer.parse(value) do
       {num,""} -> {:ok , num}
        _ -> {:erro , "valor tem que ser um inteiro"}
     end
  end

end
