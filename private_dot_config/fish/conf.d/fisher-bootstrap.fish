status is-interactive; or exit

if not functions -q fisher
  curl -sSL https://git.io/fisher | source
  and fisher update
end
