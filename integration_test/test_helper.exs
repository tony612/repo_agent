Logger.configure(level: :info)
ExUnit.start()

Code.require_file "./support/schemas.exs", __DIR__
Code.require_file "./support/migration.exs", __DIR__

alias RepoAgent.Integration.WriteRepo

Application.put_env(:repo_agent, WriteRepo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "repo_agent_master",
  pool: Ecto.Adapters.SQL.Sandbox,
  priv: "./support/")

defmodule RepoAgent.Integration.WriteRepo do
  use Ecto.Repo, otp_app: :repo_agent
end

alias RepoAgent.Integration.ReadRepo

Application.put_env(:repo_agent, ReadRepo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "repo_agent_slave",
  pool: Ecto.Adapters.SQL.Sandbox)

defmodule RepoAgent.Integration.ReadRepo do
  use Ecto.Repo, otp_app: :repo_agent
end

_   = Ecto.Storage.down(WriteRepo)
:ok = Ecto.Storage.up(WriteRepo)

_   = Ecto.Storage.down(ReadRepo)
:ok = Ecto.Storage.up(ReadRepo)

{:ok, _pid} = WriteRepo.start_link
{:ok, _pid} = ReadRepo.start_link

:ok = Ecto.Migrator.up(WriteRepo, 0, RepoAgent.Integration.Migration, log: false)
:ok = Ecto.Migrator.up(ReadRepo, 0, RepoAgent.Integration.Migration, log: false)

Process.flag(:trap_exit, true)
