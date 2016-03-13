use Mix.Config

config :repo_agent,
  write_repo: RepoAgent.TestWriteRepo,
  read_repo: RepoAgent.TestReadRepo
