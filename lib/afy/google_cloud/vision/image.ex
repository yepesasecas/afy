defmodule Afy.GoogleCloud.Vision.Image do
  use Ecto.Schema
  import Ecto.Changeset
  alias Afy.GoogleCloud.Vision.Image

  schema "images" do
    field :url, :string, virtual: true
    field :source, :string, virtual: true
  end

  @doc false
  def changeset(%Image{} = img, attrs) do
    img
    |> cast(attrs, [:url, :source])
    |> validate_required_inclusion([:url, :source])
  end

  def image_section(%Image{url: nil, source: source}), do: %{content: source}
  def image_section(%Image{source: nil, url: url}), do: %{source: %{imageUri: url}}

  defp validate_required_inclusion(changeset, fields) do
    if Enum.any?(fields, &present?(changeset, &1)) do
      changeset
    else
      # Add the error to the first field only since Ecto requires a field name for each error.
      add_error(changeset, hd(fields), "One of these fields must be present: #{inspect fields}")
    end
  end

  defp present?(changeset, field) do
    value = get_field(changeset, field)
    value && value != ""
  end
end
