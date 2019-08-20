function pgme --description 'instant, disposable postgres'
  docker run --rm -p 5432:5432 -e POSTGRES_PASSWORD=password postgres $argv
end
