let g:clipboard = {
  \   'name': 'yankee',
  \   'copy': {
  \      '+': 'yankee -i -w -s clipboard',
  \      '*': 'yankee -i -w -s primary',
  \    },
  \   'paste': {
  \      '+': 'yankee -o -w -s clipboard',
  \      '*': 'yankee -o -w -s primary',
  \   },
  \   'cache_enabled': 1,
  \ }
