defmodule PesquisaOperacionalWeb.PoHomeLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  #inicio da construcao de UI, ainda nao funcional
  def render(assigns) do
    ~L"""
    <div>
      <h1>Elixir Simplex</h1>
      <p>Método:</p>
      <p>Número de variáveis de decisão:</p>
      <p>Número de restrições:</p>
      <button>Continuar</button>
    </div>
    """
  end
end
