let g:clipboard = {
  \   'name': 'yankee',
  \   'copy': {
  \      '+': 'yankee -i -w -s clipboard',
  \      '*': 'yankee -i -w -s primary',
  \    },
  \   'paste': {
  \      '+': 'yankee -o -s clipboard',
  \      '*': 'yankee -o -s primary',
  \   },
  \   'cache_enabled': 1,
  \ }
