defmodule DashboardWeb.Admin.UserController do
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

  def index(conn, _params) do
    users = Dashboard.Repo.all(Dashboard.User)
    render conn, "index.html", users: users  
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: Dashboard.User.changeset(%Dashboard.User{}, %{})
  end

  def create(conn,  %{"user" => %{"email" => email, "name" => name, "password" => password, "role" => role}} = params) do
    user = Dashboard.User.changeset(%Dashboard.User{},%{email: email, name: name, picture: "==", hashed_password: (:crypto.hash(:sha256, password<>":"<>email)) |> Base.encode16, role: String.to_integer role})
    case Dashboard.Repo.insert(user) do
      {:ok,_} -> IO.puts("ok")
              conn |> put_flash(:info, "User inserted")
      #back is a conn, fwrd is a string
      {:error, cgst} ->
              cgst.errors |> Enum.reduce(conn, fn(now,back) -> back |> put_flash(:error,elem(now,0))  end)
      _ -> IO.puts("halting")
        conn |> halt()
    end
    conn
    |>
    redirect(to: user_path(conn, :index))
  end

  def show(conn, %{"id" => uid}) do
    import Ecto.Query
    case Dashboard.Repo.one(from u in Dashboard.User, where: u.id == ^uid) do
      user = %Dashboard.User{} -> render conn, "modify.html", changeset: Dashboard.User.changeset(user,%{}), id: uid
      nil -> conn |> put_flash(:error, "No user with this index") |> redirect(to: "/dashboard")
      _ -> conn |> halt()

    end
    
  end

  def update(conn, %{"id" => id, "user" => user}) do
    import Ecto.Query
     a = Dashboard.Repo.one(from u in Dashboard.User, where: u.id == ^id) 
    a = Dashboard.User.changeset(a, user)
    Dashboard.Repo.update a
    redirect(conn, to: user_path(conn, :index))
  end

  def new_sensor_get(conn, params) do
    render conn, "new_sensor.html", changeset: Dashboard.Sensor.Meta.changeset(%Dashboard.Sensor.Meta{},%{})
  end

end
