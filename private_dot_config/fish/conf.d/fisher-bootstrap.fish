status is-interactive; or exit

if not functions -q fisher
  curl -sL "https://git.io/fisher" | source
  and fisher update
end
