defmodule PesquisaOperacionalWeb.SimplexController do
 use PesquisaOperacionalWeb, :controller

 alias PesquisaOperacional.SimplexContext
  def all(conn,params) do
    simplexs = SimplexContext.all(params)
    
    json(conn,%{status: 200, data: simplexs})


  end
end
