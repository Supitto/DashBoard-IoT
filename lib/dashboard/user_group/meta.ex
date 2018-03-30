defmodule Dashboard.UserGroup.Meta do
  use Ecto.Schema
  import Ecto.Changeset


  schema "meta_user_group" do
    field :description, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(meta, attrs) do
    meta
    |> cast(attrs, [:name, :description])
    |> validate_required([:name, :description])
  end
end
