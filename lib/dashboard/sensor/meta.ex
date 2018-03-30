defmodule Dashboard.Sensor.Meta do
  use Ecto.Schema
  import Ecto.Changeset


  schema "meta_sensor" do
    field :local, :string
    field :manufacturer, :string
    field :name, :string
    field :purpouse, :string
    field :status, :integer

    timestamps()
  end

  @doc false
  def changeset(meta, attrs) do
    meta
    |> cast(attrs, [:name, :local, :purpouse, :manufacturer, :status])
    |> validate_required([:name, :local, :purpouse, :manufacturer, :status])
  end
end
