defmodule Dashboard.Repo.Migrations.CreateLogSensor do
  use Ecto.Migration

  def change do
    create table(:log_sensor) do
      add :value, :string
      add :meta_sensor_id, references(:meta_sensor, on_delete: :nothing)
      add :time, :utc_datetime
      timestamps()
    end

    create index(:log_sensor, [:meta_sensor_id])
  end
end
