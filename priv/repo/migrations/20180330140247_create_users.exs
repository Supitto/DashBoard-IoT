defmodule Dashboard.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string, null: false
      add :hashed_password, :string
      add :role, :integer
      add :active, :boolean, default: false, null: false
      add :picture, :string

      timestamps()
    end
    create unique_index(:users, [:email])

  end
end
