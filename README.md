# ~/.dotfiles

## Installation

```sh
# chezmoi:
sudo pacman -S chezmoi # arch
snap install chezmoi --classic # snap
brew install twpayne/taps/chezmoi # macos
curl -sfL https://git.io/chezmoi | sh -s -- -b ~/.local/bin # universal
# dotfiles:
~/.local/bin/chezmoi init https://github.com/neersighted/dotfiles --apply
```

Restart your shell to make sure the changes are fully applied.

## License

This project is licensed under the
[MIT](https://en.wikipedia.org/wiki/MIT_License) license.

See LICENSE for more details.
