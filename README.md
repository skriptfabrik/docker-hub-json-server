# JSON Server Docker Images

[![Continuous Integration](https://github.com/skriptfabrik/docker-hub-json-server/actions/workflows/ci.yml/badge.svg)](https://github.com/skriptfabrik/docker-hub-json-server/actions/workflows/ci.yml)

> Dockerized [JSON Server](https://github.com/typicode/json-server) - provides REST API mocking based on plain JSON files

## Usage

The recommended way to run this container looks like this:

```bash
docker run -d -p 80:80 skriptfabrik/json-server
```

This will expose the JSON Server REST API on port 80, so that you can now browse to [http://localhost/](http://localhost/).

### JSON Source

To get JSON responses from the API, you need to mount a file named `/data/db.json`, it will automatically be used as the plain JSON data source file.

A sample file could look like this:

```json
{
  "tasks": [
    { "id": 1, "task": "brew beer" },
    { "id": 2, "task": "drink beer" }
  ],
  "comments": [
    { "id": 1, "task": 1, "comment": "which beer" },
    { "id": 2, "task": 1, "comment": "the best" }
  ]
}
```

Save it as `db.json` to your working directory and mount it into the container:

```bash
docker run -d -p 80:80 -v `pwd`:/data:ro skriptfabrik/json-server
```

You can now browse to [http://localhost/tasks/](http://localhost/tasks/) and see the specified task list.

### JSON Routes

It is possible to inject a route configuration:

```json
{
    "/api/v1/*": "/$1"
}
```

Save it as `routes.json` and the server will provide the `tasks` and `comments` from the example above behind the base href `/api/v1/`.

### Static Files

You can provide some static files in a `./public` directory. This directory must also be mounted like the source or routes above.

```bash
echo 'Hello World!' > public/index.html
```

Run the container and browse to [http://localhost/](http://localhost/). You should now see `Hello World!` in the browser.
