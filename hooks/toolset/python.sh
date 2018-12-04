# shellcheck shell=sh

toolset_subsection "Python"

pipx_install "black"
pipx_install "flake8"
pipx_install "mypy"
pipx_install "pipenv"
pipx_install "pylint"
pipx_install "python-language-server" "python-language-server[all]"
pipx_install "rwt"
