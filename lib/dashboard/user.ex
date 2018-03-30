defmodule Dashboard.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :active, :boolean, default: false
    field :email, :string
    field :hashed_password, :string
    field :name, :string
    field :picture, :string
    field :role, :integer

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :hashed_password, :role, :active, :picture])
    |> validate_required([:name, :email, :hashed_password, :role, :active, :picture])
  end

  def auth do
    :auth_granted
  end
end
