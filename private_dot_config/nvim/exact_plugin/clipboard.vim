" Use clipboard-provider for all clipboard handling.
let g:clipboard = {
  \   'copy': {
  \      '+': 'clipboard-provider copy',
  \      '*': 'COPY_PROVIDERS=tmux clipboard-provider copy',
  \    },
  \   'paste': {
  \      '+': 'clipboard-provider paste',
  \      '*': 'PASTE_PROVIDERS=tmux clipboard-provider paste',
  \   },
  \ }
