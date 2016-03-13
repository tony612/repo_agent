defmodule RepoAgent.IntegrationTest do
  use ExUnit.Case
  alias RepoAgent.Integration.WriteRepo
  alias RepoAgent.Integration.ReadRepo
  alias RepoAgent.Integration.Post

  setup do
    Application.put_env(:repo_agent, :write_repo, WriteRepo)
    Application.put_env(:repo_agent, :read_repo, ReadRepo)
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(ReadRepo)
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(WriteRepo)
    :ok
  end

  def insert_post(repo, params \\ %{}) do
    %Post{}
    |> Post.changeset(params)
    |> repo.insert!
  end

  test "all/2" do
    insert_post(WriteRepo, %{title: "Post Master"})
    insert_post(ReadRepo, %{title: "Post Slave"})
    assert [%Post{title: "Post Slave"}] = RepoAgent.all(Post)
  end

  test "delete/2" do
    post = insert_post(WriteRepo, %{title: "Post Master"})
    insert_post(ReadRepo, %{title: "Post Slave"})
    RepoAgent.delete(post)
    assert WriteRepo.all(Post) == []
    refute ReadRepo.all(Post) == []
  end

  test "insert/2" do
    %Post{}
    |> Post.changeset(%{title: "Post Master"})
    |> RepoAgent.insert
    assert [%Post{title: "Post Master"}] = WriteRepo.all(Post)
    assert [] = ReadRepo.all(Post)
  end

  test "update/2" do
    post = insert_post(WriteRepo, %{title: "Post Master"})
    insert_post(ReadRepo, %{title: "Post Master"})
    post = Ecto.Changeset.change post, title: "New Post"
    RepoAgent.update(post)
    assert [%Post{title: "New Post"}] = WriteRepo.all(Post)
    assert [%Post{title: "Post Master"}] = ReadRepo.all(Post)
  end
end
