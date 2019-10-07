# AFY
My own API or AFY.
Any API Web Service that I want to play with will be included.

## Documentation
- [postman](https://documenter.getpostman.com/view/2204425/RWaDXX8M)

## Logs
I'm using [papertrail](https://papertrailapp.com) to keep production logs and search.

## Host
I'm hosting AFY in [Gigalixir](https://gigalixir.com)

## Authentication
I'm using [Guardian](https://hex.pm/packages/guardian) for JWT.
[comeonin](https://hex.pm/packages/comeonin) and [bcrypt_elixir](https://hex.pm/packages/bcrypt_elixir) for Password hashing.

## CI/CD
I'm using TravisCI.
Gigalixir has a simple travis.yml file. https://gigalixir.readthedocs.io/en/latest/main.html#how-to-set-up-continuous-integration-ci-cd
also, TravisCI is well documented.

## Basic Google Vision
1. Upload image and obtain object names in image.
2. Upload image and obtain text in image.

## Releases
I'm using [Distillery](https://hex.pm/packages/distillery).

# TODO
- Twilio
- Hue
- Watson
- 3CE
- Uber

# Intall

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).
