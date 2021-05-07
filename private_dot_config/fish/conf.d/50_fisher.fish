status is-interactive; or exit

function __fisher_bootstrap --on-event fish_startup
  if not functions -q fisher
    curl -sSL https://git.io/fisher | source
    and fisher update
  end

  functions -e __fisher_bootstrap
end
