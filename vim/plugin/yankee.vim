let g:clipboard = {
  \   'name': 'yankee',
  \   'copy': {
  \      '+': 'yankee-yank -w -s clipboard',
  \      '*': 'yankee-yank -w -s primary',
  \    },
  \   'paste': {
  \      '+': 'yankee-paste -w -s clipboard',
  \      '*': 'yankee-paste -w -s primary',
  \   },
  \   'cache_enabled': 1,
  \ }
