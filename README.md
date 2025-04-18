# The Knot Worldwide
### Technical challenge for data engineering position

This challenge include two basic lines: SQL and Python. 

### Project setup
1) Configure a Docker comppose with Postgress db: docker folder in root
2) Run Postgres on docker 
    $docker compose -f docker/docker-compose.yml up -d
3) Create a DBT project: This is an additional point I want to use, because although it is not included in the challenge, this position requires DBT knowledge.
    $ mkdir dbt & cd dbt
    $ dbt init
    $ cd tkww_data_engineer
    $ dbt run
    $ dbt test

NOTE: ensure you have already installed dbt locally
    $ pip3 install dbt-postgres
Credentials saving
To protect credentials and prevent them from being exposed on the Internet, env variables can be used. you need to define it on Terminal, and lated use it instead of hardcoded credentials.

### Postgres configuration
1) There are many ways to create and populate tables, such as using psql in the terminal, with Dveaber, or any other interface. In this case, I decided to create a SQL file to share the code. It's saved in the SQL folder.

Use the table_definition.sql to create and populate the tables on docker postgres.
    $ docker exec -i tkww_postgres psql -U postgres -d tkww_product < sql/table_definition.sql

![Alt text](images/sql_create_populate.png)

