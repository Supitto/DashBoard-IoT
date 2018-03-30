defmodule Dashboard.UserGroup.Log do
  use Ecto.Schema
  import Ecto.Changeset


  schema "log_user_group" do
    field :users_id, :id
    field :meta_user_group_id, :id

    timestamps()
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [])
    |> validate_required([])
  end
end
