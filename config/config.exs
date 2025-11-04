import Config
config :github_issues,
  github_url: "https://api.github.com"

config :logger,
  compile_time_purge_matching: [
    [level_lower_than: :info]
  ]
config :logger, :default_formatter,
  format: "$time $metadata[$level] $message\n", # デフォルトフォーマットでは最初に改行するのでそれを除く
  colors: [info: :green]
