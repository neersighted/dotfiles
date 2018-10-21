# ~/.dotfiles

## Installation

Clone this repo down and run the included bootstrapping script (this script is
also used to keep things up to date).

```sh
git clone https://github.com/neersighted/dotfiles "$HOME/.dotfiles"
$HOME/.dotfiles/local/bin/bootstrap
```

Restart your shell to make sure the changes are fully applied.

Any additional tags (see below) may now be selected with `rcup -t`:

```sh
rcup -t gui
```

## Tags

Additional dotfiles are categorized and selectively linked under tags.
Currently they are:

* `gui` (systems with graphical applications)
* `systemd` (systems using system user sessions)
* `x11` (systems using the x11 display server)

## License

This project is licensed under the
[MIT](https://en.wikipedia.org/wiki/MIT_License) license.

See LICENSE for more details.
