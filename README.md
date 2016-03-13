# RepoAgent

A super simple package for read-write splitting.

## Usage

config

```elixir
config :repo_agent,
  write_repo: MasterRepo,
  read_repo: SlaveRepo
```

1\. Normal read-write splitting. Just like a normal Repo

```elixir
defmodule PostController do
  alias RepoAgent, as: Repo

  def index do
    Repo.all(Post)
  end

  def create do
    %Post{}
    |> Post.changeset(%{title: "AlphaGo vs Lee"})
    |> Repo.insert
  end
end
```

2\. You want to use master db for both write and read, e.g. payment. Just use the `MasterRepo`
