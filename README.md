# AFY
My own API or AFY.
Any API Web Service that I want to play with will be included.

## Documentation
I'm using [postman](https://documenter.getpostman.com/view/2204425/RWaDXX8M)

## Logs
I'm using [papertrail](https://papertrailapp.com) to keep production logs and search.

## Host
I'm hosting AFY in [Gigalixir](https://gigalixir.com)

## Authentication
I'm using [Guardian](https://hex.pm/packages/guardian) for JWT.
[comeonin](https://hex.pm/packages/comeonin) and [bcrypt_elixir](https://hex.pm/packages/bcrypt_elixir) for Password hashing.

## Basic Google Vision
1. Upload image and obtain object names in image.
2. Upload image and obtain text in image.

## 3CE
i'm using my own HS library to consume 3CE API. 

## Releases
I'm using [Distillery](https://hex.pm/packages/distillery).

# TODO
- Twilio
- Hue
- Watson
- Uber
- Apple Notifications (Pushex?)

# Intall

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).
