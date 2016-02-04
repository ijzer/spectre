# spectre
Music streaming server written in [Elixir](elixir-lang.org).

## API

Spectre has 2 API versions. The first is mostly
[Subsonic](www.subsonic.org) compatible, except for functions documented in
the [Subsonic API spec](docs/api/subsonic.raml). The second is a custom
RESTful framework because the Subsonic API is shit and I hate it. That's
documented in the [Spectre API spec](docs/api/spectre.raml).

## Requirements

To build: Elixir, Erlang
To run: Erlang, redis

## TODO
- [ ] router and basic stuff
- [ ] songs/albums/artists
- [ ] audio
- [ ] images
- [ ] users
- [ ] authentication
- [ ] ratings/stars/playcount
- [ ] rate limiting
- [ ] audio file tag parsing
- [ ] mix task to add files to database
- [ ] playlists
- [ ] bookmarks
- [ ] user queues
- [ ] podcasts
- [ ] searching
- [ ] android client
