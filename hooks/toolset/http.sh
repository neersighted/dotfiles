# shellcheck shell=sh

toolset_subsection "HTTP"

go_get "github.com/codesenberg/bombardier"
pipx_install "httpie"
go_get "github.com/davecheney/httpstat"
go_get "github.com/loadimpact/k6"
go_get "github.com/tsenart/vegeta"
