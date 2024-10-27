# Snowflake SQL Buildkite Plugin

*NOTE: The intent of this project is to test out an idea and it's not meant for production.*

Runs SQL in Snowflake to allow Buildkite to become a data engineering pipeline orchestration framework like Airflow.

## Rationale

**CONTEXT:** I've led data engineering as part of my last two roles. ETL (Extract, Transform, Load) tooling is challenging to develop against and operate.

- Configuring and operating tools is time consuming, usually requiring full time staff.
- Airflow uses Python specific DSL for creating pipelines - requiring developers to lock into that tool.
- Microsoft Azure Data Factory produces JSON that is hard to peer review using a pull request process and integrate will with Git.
- Connecting with alerting tools like Slack is another item to manage.

**BACKGROUND:** Data engineering splits into batch data ETL (or ELT) and streaming. Many companies use batch. And the focus for this experiment is batch ETL.

- Examples of tools in this space are https://airflow.apache.org/ and https://azure.microsoft.com/en-us/products/data-factory.
- There are many reasons to use existing tooling for ETL e.g., active community, focus on specifics of ETL, breadth of connectors.

**WHY TRY BUILDKITE TOOLS** for Data Pipeline Orchestration:

"Airflow® is a batch workflow orchestration platform. The Airflow framework contains operators to connect with many technologies and is easily extensible to connect with a new technology. If your workflows have a clear start and end, and run at regular intervals, they can be programmed as an Airflow DAG." https://airflow.apache.org/docs/apache-airflow/stable/index.html

Builtkite has significant overlaps with Airflow's capabilities:

| Capability | Airflow | Buildkite |
| :-------- | :------: | :------: |
| Batch processing | Yes |Yes |
| Schedule jobs / pipelines | Yes | Yes |
| Directed acyclic graph | Yes | Yes |
| Extensible programming model | Yes | Yes |
| Control retries | Yes | Yes |

Buildkite excels in extensibility because it allows developers to use any technology (by working at an OS / Docker level) and stitches interactions together through YAML.

- Buildkite's hybrid architecture gives large customers control over their infrastructure without having to host user interfaces and connectors to alerting systems.
- Existing plugin ecosystem makes it simple to connect with external systems for alerting.

**THOUGHT EXPERIMENT:** This implementation isn't fully featured, instead designed to test out the idea.

- Value interpolation in SQL would need to be implemented.
- Connecting to Snowflake bindings in API hasn't been built.
- Ability to read results and run jobs based on logic isn't part of the implementation.
- Ideally generation of the authentication JWT would be done by this plugin.

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

Your Snowflake account - i.e., `https://${ACCOUNT}.snowflakecomputing.com/`.

### `jwt` (Required, string)

Your authentication token for working with Snowflake. In the future this will be generated for you by this plugin. For more info on how to generate a Snowflake JWT see https://docs.snowflake.com/en/developer-guide/sql-api/authenticating#label-sql-api-authenticating-key-pair.

### `path` (Required, string)

The path to your SQL file that will be executed on your Snowflake environment.

### `timeout` (Required, number)

How many seconds your sql call can run for.

### `database` (Required, string)

Which database is your data sitting in.

### `schema` (Required, number)

What schema contains the tables you are looking at.

### `warehouse` (Required, number)

What compute infrastructure should be used to run your query.

### `role` (Required, number)

What role is setup to execute this query.

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
