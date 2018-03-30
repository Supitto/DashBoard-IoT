defmodule Dashboard.Repo.Migrations.CreateLogUserGroup do
  use Ecto.Migration

  def change do
    create table(:log_user_group) do
      add :users_id, references(:users, on_delete: :nothing)
      add :meta_user_group_id, references(:meta_user_group, on_delete: :nothing)

      timestamps()
    end

    create index(:log_user_group, [:users_id])
    create index(:log_user_group, [:meta_user_group_id])
  end
end
