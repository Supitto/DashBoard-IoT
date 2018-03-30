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
    get "/sensor/especifico", DashboardController, :sensor_especifico
    get "/logout", DashboardController, :logout
  end

  scope "/admin", DashboardWeb do
    pipe_through :browser

    get "/users", AdminController, :users
    get "/users/new", AdminController, :new_user_get
    post "/users/new", AdminController, :new_user_post
    get "/users/modify", AdminController, :modify_user_get
		post "/users/modify", AdminController, :modify_user_post
  end

  # Other scopes may use custom stacks.
  # scope "/api", DashboardWeb do
  #   pipe_through :api
  # end
end
