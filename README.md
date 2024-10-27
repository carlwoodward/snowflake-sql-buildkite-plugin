# Snowflake SQL Buildkite Plugin

*NOTE: The intent of this project is to test out an idea and it's not meant for production.*

Runs SQL in Snowflake to allow Buildkite to become a data engineering pipeline orchestration framework like AirFlow.

## Example

Add the following to your `pipeline.yml`:

```yml
steps:
  - command: ls
    plugins:
      - carlwoodward/snowflake-sql#v1.0.0:
          account: '********'
          jwt: '***************************************************'
          sql_path: 'test.sql'
```

## Configuration

### `account` (Required, string)

Your Snowflake account - i.e., https://${ACCOUNT}.snowflakecomputing.com/.

### `jwt` (Required, string)

Your authentication token for working with Snowflake. In the future this will be generated for you by this plugin. For more info on how to generate a Snowflake JWT see https://docs.snowflake.com/en/developer-guide/sql-api/authenticating#label-sql-api-authenticating-key-pair.

### `path` (Required, string)

The path to your SQL file that will be executed on your Snowflake environment.

## Developing

To run the tests:

```shell
docker-compose run --rm tests
```

## Contributing

1. Fork the repo
2. Make the changes
3. Run the tests
4. Commit and push your changes
5. Send a pull request
