defmodule PesquisaOperacionalWeb.PoHomeLive do
  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  #inicio da construcao de UI, ainda nao funcional
  def render(assigns) do
    ~H"""
    <h1 class="text-center font-bold">Elixir Simplex</h1>
    <div class="text-center">
      <p>Método:</p>
      <.form for={:new_po} let={f} phx-submit="po_form_submit">
          <%= text_input f, :message %>
      </.form>
      <p>Número de variáveis de decisão:</p>
      <input type="text" />
      <p>Número de restrições:</p>
      <input type="text" />
      <br>
      <button class="bg-cyan-400">Confirmar</button>
    </div>
    """
  end

  def handle_event("po_form_submit", %{"po_form" => %{"message" => message}}, socket) do

    {:noreply, socket}
  end
end
