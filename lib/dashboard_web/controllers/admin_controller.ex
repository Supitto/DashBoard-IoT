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
    render conn, "users.html", users:  Dashboard.Repo.all(Dashboard.User), menu: true
  end

  def new_user_get(conn, _params) do
    render conn, "new_user.html", changeset: Dashboard.User.changeset(%Dashboard.User{}, %{}), menu: true
  end

  def new_user_post(conn,  %{"user" => %{"email" => email, "password" => password, "role" => role}} = params) do
    #conn |> put_flash(:info,
    #						Dashboard.Repo.insert(%Dashboard.User{email: email, pass_hash: (:crypto.hash(:sha256, password<>":"<>email)) |> Base.encode16, role: String.to_integer role})
    #						|> elem(0)
    #						|> case do
    #  							:ok -> "Sucesso"
    #  							_	-> "Falha"
    #							end)
    conn 
    |> redirect( to: "/admin/users")
  end

	def modify_user_get(conn, %{"id" => uid}) do
		import Ecto.Query
		render conn, "modify_user.html"#, changeset: Dashboard.User.changeset(%Dashboard.User{},%{}), menu: true
	end

end
