defmodule DashboardWeb.DashboardController do
  use DashboardWeb, :controller

  def index(conn, _params) do
  render conn, "index.html", menu: true
  end

  def sensor(conn, _param) do
    render conn, "sensor.html", sensores: [%{id: 32423524, nome: "sensor 1",valor: 10}], menu: true
  end

  def sensor_especifico(conn, %{"id" => id}) do
    render conn, "sensor_especifico.html", sensor: %{id: "asda", nome: "sensor1", last_data: [1,2,3,4,5]}, menu: true
  end
end
