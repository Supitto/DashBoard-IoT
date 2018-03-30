defmodule Dashboard.Sensor.Log do
  use Ecto.Schema
  import Ecto.Changeset


  schema "log_sensor" do
    field :date, :utc_datetime
    field :value, :string
    field :meta_sensor_id, :id

    timestamps()
  end

  @doc false
  def changeset(log, attrs) do
    log
    |> cast(attrs, [:value, :date])
    |> validate_required([:value, :date])
  end
end
