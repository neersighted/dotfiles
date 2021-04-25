# ~/.dotfiles

## Installation

```sh
# linux, macos:
curl -sSfL https://raw.githubusercontent.com/neersighted/dotfiles/master/bootstrap.sh | sh
# freebsd:
fetch -o - https://raw.githubusercontent.com/neersighted/dotfiles/master/bootstrap.sh | sh
```
```pwsh
# windows:
(iwr -UseBasicParsing https://git.io/chezmoi.ps1).Content | powershell -c -; .\bin\chezmoi.exe init --apply --remove neersighted
```

Restart your shell to make sure the changes are fully applied.

## License

This project is licensed under the
[MIT](https://en.wikipedia.org/wiki/MIT_License) license.

See LICENSE for more details.
