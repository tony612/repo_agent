defmodule RepoAgentTest do
  use ExUnit.Case

  setup do
    Application.put_env(:repo_agent, :write_repo, RepoAgent.FakeWriteRepo)
    Application.put_env(:repo_agent, :read_repo, RepoAgent.FakeReadRepo)
    :ok
  end

  test "all/2" do
    assert RepoAgent.all("query", []) == "all/2 from TestReadRepo"
  end

  test "delete/2" do
    assert RepoAgent.delete("query", []) == "delete/2 from TestWriteRepo"
  end

  test "insert/2" do
    assert RepoAgent.insert("query", []) == "insert/2 from TestWriteRepo"
  end

  test "update/2" do
    assert RepoAgent.update("query", []) == "update/2 from TestWriteRepo"
  end
end
