defmodule Afy.Jay.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "jay_users" do
    field :device_token, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :device_token])
    |> validate_required([:username, :device_token])
    |> unique_constraint(:username)
  end
end
