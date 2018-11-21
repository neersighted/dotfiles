# ~/.dotfiles

## Installation

First, use your install method of choice to get
[rcm](https://github.com/thoughtbot/rcm) into your `$PATH`. Some common methods
are listed here:

```sh
# ubuntu
sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
sudo apt install rcm
# debian
curl https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -
echo "deb https://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
sudo apt-get update
sudo apt-get install rcm
# freebsd
pkg install rcm
# macos
brew install thoughtbot/formulae/rcm
```

Then, clone this repo down and install the files using `rcup`. The bootstrapping
script can then be used to provision the rest of the environment.

```sh
git clone https://github.com/neersighted/dotfiles "$HOME/.dotfiles"
RCRC="$HOME/.dotfiles/rcrc" rcup -v
$HOME/.local/bin/bootstrap
```

Once the script finishes, you may want to install additional (tagged) dotfiles.
Select from the tags below and run:

```sh
rcup -t [tag...]
```

Restart your shell to make sure the changes are fully applied.

## Tags

* `gui` (systems with graphical applications)
* `wsl` (systems running under the windows subsystem for linux)
* `x11` (systems using the x11 display server)

## License

This project is licensed under the
[MIT](https://en.wikipedia.org/wiki/MIT_License) license.

See LICENSE for more details.
