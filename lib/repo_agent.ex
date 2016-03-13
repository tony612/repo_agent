defmodule RepoAgent do
  def all(queryable, opts \\ []) do
    read_repo.all(queryable, opts)
  end

  def delete(struct, opts \\ []) do
    write_repo.delete(struct, opts)
  end

  def insert(struct, opts \\ []) do
    write_repo.insert(struct, opts)
  end

  def update(struct, opts \\ []) do
    write_repo.update(struct, opts)
  end

  defp read_repo do
    Application.fetch_env!(:repo_agent, :read_repo)
  end

  defp write_repo do
    Application.fetch_env!(:repo_agent, :write_repo)
  end
end
