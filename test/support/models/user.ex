defmodule OpentelemetryEtso.TestModels.User do
  use Ecto.Schema

  schema "users" do
    field(:email, :string)

    has_many(:posts, OpentelemetryEtso.TestModels.Post)
  end
end
