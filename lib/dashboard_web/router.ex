defmodule DashboardWeb.Router do
  use DashboardWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DashboardWeb do
    pipe_through :browser # Use the default browser stack

    get "/", LoginController, :index
    post "/", LoginController, :auth
    get "/recover", LoginController, :recover_get
    post "/recover", LoginController, :recover_post
  end

  scope "/dashboard", DashboardWeb do
    pipe_through :browser

    get "/", DashboardController, :index
    get "/sensor", DashboardController, :sensor
    get "/sensor/:idphx", DashboardController, :sensor_especifico
    get "/logout", DashboardController, :logout
  end

  scope "/admin", DashboardWeb do
    pipe_through :browser

    resources "/user", Admin.UserController
    resources "/sensor", Admin.SensorController
    
  end

  # Other scopes may use custom stacks.
  # scope "/api", DashboardWeb do
  #   pipe_through :api
  # end
end
