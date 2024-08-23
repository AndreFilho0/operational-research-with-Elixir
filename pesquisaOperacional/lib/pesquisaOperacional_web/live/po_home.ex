defmodule PesquisaOperacionalWeb.PoHomeLive do
  use PesquisaOperacionalWeb, :live_view

  def mount(_params, _session, socket) do
    # Inicialize :new_po e :funcoes com mapas vazios ou com valores padrão
    new_po = %{var_decisao: "", num_restricao: "", objetivo: ""}

    funcoes = %{
      objetivo: [],
      tipo: "",
      restricoes: []
    }

    {:ok, assign(socket, new_po: new_po, funcoes: funcoes, submitted: false)}
  end

  def handle_event(
        "po_form_submit",
        %{"var_decisao" => var_decisao, "num_restricao" => num_restricao},
        socket
      ) do
    new_po = %{
      var_decisao: var_decisao,
      num_restricao: num_restricao
    }

    {:noreply, assign(socket, new_po: new_po, submitted: true)}
  end

  def handle_event(
        "po_form_funcoes_submit",
        %{
          "tipo" => tipo,
          "var_decisao" => var_decisao,
          "var_restricao" => var_restricao,
          "condicao" => condicoes,
          "valor" => valores
        },
        socket
      ) do
    funcoes = %{
      objetivo: Enum.map(var_decisao, &String.to_integer/1),
      tipo: tipo,
      restricoes:
        Enum.zip([var_restricao, condicoes, valores])
        |> Enum.map(fn {coef, cond, val} ->
          %{
            "coeficientes" => Enum.map(coef, &String.to_integer/1),
            "tipo" => cond,
            "valor" => String.to_integer(val)
          }
        end)
    }

    IO.puts(inspect(funcoes))
    send_post_request(funcoes)

    {:noreply, socket}
  end

  defp send_post_request(json_body) do
    # Envie a requisição HTTP POST
    url = "http://example.com/api"
    headers = [{"Content-Type", "application/json"}]

    case HTTPoison.post(url, Jason.encode!(json_body), headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts("Requisição bem-sucedida: #{body}")

      {:ok, %HTTPoison.Response{status_code: code}} ->
        IO.puts("Falha na requisição. Código: #{code}")

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts("Erro na requisição: #{reason}")
    end
  end
end
