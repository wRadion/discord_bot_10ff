Discord Bot 10FF
===============

A Discord Bot written in Ruby for the french 10FastFingers community.

- Discord: https://discord.gg/HfPwS34
- 10FastFingers: https://10fastfingers.com/

## Requirements

Obviously, you'll need `ruby`. The version used in this project is `ruby-2.5.1` as specified by the Gemfile.

You'll need `chromedriver` installed (and a Google Chrome binary too, either `chromium` or `google-chrome`).

Then just launch `chromedriver`:

```
$ chromedriver
Starting ChromeDriver 2.?? on port 9515
Only local connections are allowed.
```

And you're done!

## How To Use

You will have to set the following environment variables before using this bot:
- `DISCORD_OWNER_ID` _(optional)_ : The Discord Id of the owner of this bot
- `DISCORD_TOKEN` _(mandatory)_ : The Token
- `DISCORD_CLIENT_ID` _(mandatory)_ : The Client Id

Then, start the bot using the `main.rb` file:

```
$ ruby main.rb
```

And voilà!

### Database Migrations

This project uses *sqlite* as a database, and the *sequel* gem as the Ruby API.

Create your migration in `db/migrate/`.
[Here is some help](https://github.com/jeremyevans/sequel/blob/master/doc/migration.rdoc) if you don't know how to write a Sequel migration.

The file **must** be following this format: `XXX_<name>.rb`.
Where `XXX` is a 3 digits numbers, and must be the one following the last number present in the folder.

Example: if you see a file named `023_create_users.rb`, your next migration **must** be called `024_<something>.rb`.

Then, just run the shell script in `scripts/`:

```
$ ./scripts/migrate
```

### Ruby console

You can start a Ruby console with everything setup using the following shell scripts:

```
$ ./scripts/console
```

## Contributing

- Fork this repository
- Create a new branch `git checkout -b <branch-name>`
- Do your stuff
- Create a pull request on this repository
- Wait for validation!

## Maintainer

wRadion <<wradion@gmail.com>>
