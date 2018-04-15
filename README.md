# ~/.dotfiles

## Setup

First, install [rcm] in order to symlink dotfiles into place.

Debian:
```sh
wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -
echo "deb http://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
sudo apt-get update
sudo apt-get install rcm
```

Ubuntu:
```sh
sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
sudo apt-get update
sudo apt-get install rcm
```

Fedora:
```sh
sudo dnf copr enable seeitcoming/rcm
sudo dnf install rcm
```

FreeBSD:
```sh
sudo pkg install rcm
```

macOS:
```sh
brew tap thoughtbot/formulae
brew install rcm
```

## Installation

Next, clone this repo down and link the files with `rcup`:

```sh
git clone https://github.com/neersighted/dotfiles "$HOME/.dotfiles"
env RCRC="$HOME/.dotfiles/rcrc" rcup
```

Finally, bootstrap the environment with the `bootstrap` script:

```sh
bootstrap
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


[rcm]: https://github.com/thoughtbot/rcm
