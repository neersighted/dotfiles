# ~/.dotfiles

## Installation

First, use your install method of choice to get
[rcm](https://github.com/thoughtbot/rcm) into your `$PATH`. Some common methods
are listed here:

```sh
# arch
git clone https://aur.archlinux.org/rcm /tmp/rcm
cd /tmp/rcm && makepkg -si
# freebsd
pkg install git rcm
# macos
brew install thoughtbot/formulae/rcm
```

Then, clone this repo down and install the files using `rcup`. Environment
bootstrapping will occur after the dotfiles are installed.

```sh
git clone https://github.com/neersighted/dotfiles "$HOME/.dotfiles"
env RCRC="$HOME/.dotfiles/rcrc" rcup -v -t <tags>
```

Restart your shell to make sure the changes are fully applied.

## License

This project is licensed under the
[MIT](https://en.wikipedia.org/wiki/MIT_License) license.

See LICENSE for more details.
