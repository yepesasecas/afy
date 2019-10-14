defmodule Afy.Repo.Migrations.CreateJayUsers do
  use Ecto.Migration

  def change do
    create table(:jay_users) do
      add :username, :string
      add :device_token, :string

      timestamps()
    end

    create unique_index(:jay_users, [:username])
  end
end
