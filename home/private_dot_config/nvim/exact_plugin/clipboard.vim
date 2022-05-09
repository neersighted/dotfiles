" Use clipboard-provider for all clipboard handling.
let g:clipboard = {
  \   'copy': {
  \      '*': 'env COPY_PROVIDERS=tmux clipboard-provider copy',
  \      '+': 'env COPY_PROVIDERS=desktop clipboard-provider copy',
  \    },
  \   'paste': {
  \      '*': 'env PASTE_PROVIDERS=tmux clipboard-provider paste',
  \      '+': 'env PASTE_PROVIDERS=desktop clipboard-provider paste',
  \   },
  \ }
