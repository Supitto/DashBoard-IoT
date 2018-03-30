defmodule DashboardWeb.DashboardController do
  use DashboardWeb, :controller

  plug :auth
  plug :put_menu

  defp auth(conn, params) do
    case get_session(conn, :user_id) do
      nil -> redirect(conn, to: "/")  |> halt()
      _ -> conn
    end
  end

  defp put_menu(conn, params) do
    conn
    |> put_layout({DashboardWeb.LayoutView, "menu.html"})
  end

  def index(conn, _params) do
    IO.puts get_session(conn,:user_group)
    render conn, "index.html"
  end

  def sensor(conn, _param) do
    render conn, "sensor.html", sensores: [%{id: 32423524, nome: "sensor 1",valor: 10}], menu: true
  end

  def sensor_especifico(conn, %{"id" => id}) do
    render conn, "sensor_especifico.html", sensor: %{id: "asda", nome: "sensor1", last_data: [1,2,3,4,5]}, menu: true
  end

  def logout(conn, _params) do
    conn
    |> clear_session
    |> redirect(to: "/")
  end
end
