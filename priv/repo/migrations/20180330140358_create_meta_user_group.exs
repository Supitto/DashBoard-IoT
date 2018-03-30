defmodule Dashboard.Repo.Migrations.CreateMetaUserGroup do
  use Ecto.Migration

  def change do
    create table(:meta_user_group) do
      add :name, :string
      add :description, :string

      timestamps()
    end

  end
end
