defmodule Chat.AuthController do
  use Chat.Web, :controller

  plug Ueberauth

  alias Chat.User

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider} = params) do
    user_params = %{personaname: auth.extra.raw_info.user.personaname, steamid: auth.extra.raw_info.user.steamid, provider: provider}
    changeset = User.changeset(%User{}, user_params)
    IO.puts("+++++")
    IO.inspect(user_params)
    IO.puts("+++++")
    IO.inspect(conn)
    IO.puts("+++++")
    IO.inspect(params)
    IO.puts("+++++")

    signin(conn, changeset)
  end

  defp signin(conn, changeset) do
    case insert_or_update_user(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> put_session(:user_id, user.id)
        |> redirect(to: room_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signing in")
        |> redirect(to: room_path(conn, :index))
    end
  end

  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: room_path(conn, :index))
  end

  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, personaname: changeset.changes.personaname) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end
end
