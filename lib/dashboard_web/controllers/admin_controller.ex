defmodule DashboardWeb.AdminController do
  use DashboardWeb, :controller

  plug :auth_admin
  plug :put_menu

  defp auth_admin(conn, params) do
    case get_session(conn, :user_role) do
      0 -> conn
      _ -> redirect(conn, to: "/")  |> halt()
    end
  end

  defp put_menu(conn, params) do
    conn
    |> put_layout({DashboardWeb.LayoutView, "menu.html"})
  end

  def users(conn, _params) do
    users = Dashboard.Repo.all(Dashboard.User)
    render conn, "users.html", users: users  
  end

  def new_user_get(conn, _params) do
    render conn, "new_user.html", changeset: Dashboard.User.changeset(%Dashboard.User{}, %{})
  end

  def new_user_post(conn,  %{"user" => %{"email" => email, "password" => password, "role" => role}} = params) do
    user = Dashboard.User.changeset(%Dashboard.User{},%{email: email, hashed_password: (:crypto.hash(:sha256, password<>":"<>email)) |> Base.encode16, role: String.to_integer role})
    case Dashboard.Repo.insert(user) do
      {:ok,_} -> IO.puts("ok")
              conn |> put_flash(:info, "User inserted")
      #back is a conn, fwrd is a string
      {:error, cgst} -> cgst.errors |> Enum.reduce(conn, fn(now,back) -> back |> put_flash(:error,elem(now,0))  end)
      _ -> IO.puts("halting")
        conn |> halt()
    end
    conn
    |>
    redirect(to: "/admin/users")
  end

	def modify_user_get(conn, %{"id" => uid}) do
		import Ecto.Query
		render conn, "modify_user.html"#, changeset: Dashboard.User.changeset(%Dashboard.User{},%{})
	end

  def sensor(conn, _params) do
    render conn, "sensor.html"
  end

  def new_sensor_get(conn, params) do
    render conn, "new_sensor.html", changeset: Dashboard.Sensor.Meta.changeset(%Dashboard.Sensor.Meta{},%{})
  end

end
