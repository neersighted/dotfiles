if not functions -q fisher
  source (curl -sL "https://git.io/fischer" | psub)
  fisher install jorgebucaran/fisher
end
