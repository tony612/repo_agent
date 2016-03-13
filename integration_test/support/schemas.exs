defmodule RepoAgent.Integration.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    timestamps
  end

  def changeset(model, params) do
    cast(model, params, ["title"])
  end
end
