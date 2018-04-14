function gi --description 'gitignore.io client'
  curl -L -s https://www.gitignore.io/api/$argv
end
