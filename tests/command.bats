#!/usr/bin/env bats

load "$BATS_PLUGIN_PATH/load.bash"

# Uncomment the following line to debug stub failures
export BUILDKITE_AGENT_STUB_DEBUG=/dev/tty

@test "Calls Snowflake SQL API" {
  export BUILDKITE_PLUGIN_SNOWFLAKE_SQL_ACCOUNT="testaccount"
  export BUILDKITE_PLUGIN_SNOWFLAKE_SQL_JWT="jwt"
  export BUILDKITE_PLUGIN_SNOWFLAKE_SQL_PATH="test_path.sql"

  stub buildkite-agent 'annotate "SQL run succesfully" : echo SQL run succesfully'
  stub curl 'echo Done'

  run "$PWD/hooks/command"

  assert_success
  assert_output --partial "SQL run succesfully"

  unstub buildkite-agent
}
