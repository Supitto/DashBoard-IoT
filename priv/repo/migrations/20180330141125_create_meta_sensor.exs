defmodule Dashboard.Repo.Migrations.CreateMetaSensor do
  use Ecto.Migration

  def change do
    create table(:meta_sensor) do
      add :name, :string
      add :local, :string
      add :purpouse, :string
      add :manufacturer, :string
      add :status, :integer

      timestamps()
    end

  end
end
