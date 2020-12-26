# Poll App

A poll API built with Elixir/Phoenix

I tried to use SQLite as database but new versions of Phoenix and Ecto aren´t compatible with SQLite adapters.

## First steps with Postgres

Install and start Docker on Ubuntu/WSL

```
$ sudo apt update
$ sudo apt install apt-transport-https ca-certificates curl software-properties-common
$ sudo apt install build-essential
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
$ sudo apt update
$ sudo apt install docker-ce
$ sudo service docker start
$ sudo docker run hello-world
```

Install Docker Compose

```
$ sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ sudo chmod +x /usr/local/bin/docker-compose
$ docker-compose --version
docker-compose version 1.27.4, build 40524192
```

A docker-compose file was created to start Postgress

```
$ docker-compose config
```

Run the container

```
$ sudo docker-compose up -d
$ sudo docker ps

CONTAINER ID   IMAGE             COMMAND                  CREATED          STATUS          PORTS                    NAMES
a453c46bf0ba   postgres:alpine   "docker-entrypoint.s…"   12 seconds ago   Up 11 seconds   0.0.0.0:5432->5432/tcp   elixir-poll_postgres_1
```

To access Potsgres outside WSL, if you are running an older version of Windows (Build 18945 or less), you will need to get the IP address of the Linux host VM

```
$ ip addr | grep eth0
 inet 172.17.132.19/28 brd ...
```

Inspect volume

```
$ docker volume ls
DRIVER    VOLUME NAME
local     elixir-poll_postgres
$ sudo docker volume inspect elixir-poll_postgres
[
    {
        "CreatedAt": "2020-12-26T02:48:38-03:00",
        "Driver": "local",
        "Labels": {
            "com.docker.compose.project": "elixir-poll",
            "com.docker.compose.version": "1.27.4",
            "com.docker.compose.volume": "postgres"
        },
        "Mountpoint": "/var/lib/docker/volumes/elixir-poll_postgres/_data",
        "Name": "elixir-poll_postgres",
        "Options": null,
        "Scope": "local"
    }
]
```

## First steps with Phoenix

Creating the app

```
$ mix phx.new elixir-poll --app poll_app --no-webpack --no-html
$ mix deps.get
Resolving Hex dependencies...
Dependency resolution completed:
Unchanged:
  connection 1.1.0
  cowboy 2.8.0
  cowboy_telemetry 0.3.1
  cowlib 2.9.1
  db_connection 2.3.1
  decimal 2.0.0
  ecto 3.5.5
  ecto_sql 3.5.3
  gettext 0.18.2
  jason 1.2.2
  mime 1.5.0
  phoenix 1.5.7
  phoenix_ecto 4.2.1
  phoenix_html 2.14.3
  phoenix_live_dashboard 0.4.0
  phoenix_live_view 0.15.1
  phoenix_pubsub 2.0.0
  plug 1.11.0
  plug_cowboy 2.4.1
  plug_crypto 1.2.0
  postgrex 0.15.7
  ranch 1.7.1
  telemetry 0.4.2
  telemetry_metrics 0.6.0
  telemetry_poller 0.5.1
All dependencies are up to date
```

Creating resource endpoints

Context | Poll
Schema  | Poll
Table   | polls
Fields  | question:string

```
$ mix phx.gen.json Polls Poll polls question:string
```

Creating the database

```
$ mix ecto.migrate
Compiling 17 files (.ex)
Generated poll_app app

03:04:32.972 [info]  == Running 20201226011529 PollApp.Repo.Migrations.CreatePolls.change/0 forward

03:04:33.425 [info]  create table polls

03:04:33.446 [info]  == Migrated 20201226011529 in 0.0s
```

## Starting

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## References

[Yet Another Guide To Build a JSON API with Phoenix 1.5](https://www.poeticoding.com/another-guide-to-build-a-json-api-with-phoenix-1-5/)

