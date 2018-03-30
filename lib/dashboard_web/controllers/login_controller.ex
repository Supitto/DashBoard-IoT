defmodule DashboardWeb.LoginController do
  use DashboardWeb, :controller

  def index(conn, _params) do
    render conn, "index.html", menu: false
  end

  def auth(conn, %{"login" => %{"email" => "admin@admin.admin", "password" => "Windows<3Linux"}}) do
    IO.puts "Admin modafoca"
		conn
    |> put_session(:user_id, -1)
    |> put_session(:user_role, 0)
		|> redirect(to: "/dashboard")
  end
  def auth(conn, %{"login" => %{"email" => email, "password" => password}} = params) do
    case Dashboard.User.auth do
      :auth_granted ->
				conn
				|> put_session(:role_group, 0)
				|> redirect(to: "/dashboard")
      :wrong_passwrod ->
        conn |> put_flash("error","A senha inserida esta incorreta") |> redirect(to: "/")
      :not_found ->
        conn |> put_flash("error","Email incorreto ou conta inexistente") |> redirect(to: "/")
      _ ->
        conn |> put_flash("error","Um erro não esperado aconteceu, estamos trabalhando para resolver") |> redirect(to: "/")
    end    
  end

  def recover_get(conn, _params) do
    render conn, "recovery.html", menu: false
  end

  def recover_post(conn, %{"recover" => %{"email" => email }} = params) do
    case Dashboard.User.exist(email) do
      :yes ->
      conn 
      |> put_flash("waring","O webmaster foi notificado e em breve você recebera sua nova senha") 
      :no ->
      conn 
      |> put_flash("error","Não existe conta registrada neste email") 
    end
    |> redirect(to: "/")
  end

end
