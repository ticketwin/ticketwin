# TicketWin

### Setup

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
