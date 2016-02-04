# TicketWin

### API Documentation

You can visit `api.tcktwn.dev/api` to see HTML-formatted API documentation, or 
`api.tcktwn.dev/api.json` for JSON docs.

### Authentication

The API uses headless sessions by passing a valid auth token in the request headers. Log
in by POSTing to `/sessions` with a authentication payload:

```json
{
  sessions: {
    email: 'user@example.com',
    password: 'p@ssw0rd'
  }
}
```

If authentication is successful, a user object will be returned with a temporary auth token:

```json
{
  users: {
    id: 1,
    email: 'user@example.com',
    auth_token: '74Ydu4LuR7WzZMBBj1B8G6G1',
    ...
  }
}
```

If unsuccessful:

```json
{
  errors: 'Invalid email or password'
}
```

Endpoints requiring authentication must set the header `Authorization => [auth_token]` or will return a 401.

### Setup

Requires ruby 2.3.0.

#### Clone the repo

Clone the repo into your home directory.

```bash
cd ~
git clone git@github.com:ticketwin/ticketwin
```

#### RVM and ruby

```bash
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby=2.2.2
```

#### Bundle and database

```bash
gem install bundle
bundle install
bundle exec rake db:create db:migrate db:seed
```

#### Pow

Pow is an automatic Rack server for Mac. Instead of running the rails server
manually, Pow allows you to have it always running.

```bash
cd ~/ticketwin
powder install
powder link
ln -s ~/ticketwin ~/.pow/tcktwn
```

Run `powder status` and make sure your output is similar to below:

```
pid          91814
version      0.5.0
requestCount 5
```

You can now access the ticketwin server locally by navigating to
`http://api.tcktwn.dev` in your browser.

To shut down and start up Pow, use `powder down` and `powder up`, respectively.
To restart the server, use `powder restart`. See
http://github.com/rodreegez/powder for more commands.
