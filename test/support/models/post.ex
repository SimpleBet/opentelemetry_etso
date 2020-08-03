defmodule OpentelemetryEtso.TestModels.Post do
  use Ecto.Schema

  schema "posts" do
    field(:body, :string)
    belongs_to(:user, OpentelemetryEtso.TestModels.User)
  end
end
