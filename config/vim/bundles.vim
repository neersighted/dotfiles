"
" Config
"

" Use Tim Pope's recommended, sane defaults.
NeoBundle "tpope/vim-sensible"
" EditorConfig is a universal editor configuration language.  It helps
" developers maintain constant coding styles across editors and platforms.
NeoBundle "editorconfig/editorconfig-vim"

"
" Libraries
"

" Background and asynchronous process support.
NeoBundle "Shougo/vimproc", {"build": {"mac": "make -f make_mac.mak", "unix": "make -f make_unix.mak"}}
" A pseudo-command line.
NeoBundle "junegunn/vim-pseudocl"
" Async adapters for running Vim's compiler plugins, or arbitrary commands.
NeoBundle "tpope/vim-dispatch"

" Repeat support for arbitrary plugins.
NeoBundle "tpope/vim-repeat"
NeoBundle "visualrepeat"

"
" Fixes/Tweaks
"

" Makeshift automatically detects and sets the makeprg based on build files
" found in the project root.
NeoBundle "johnsyweb/vim-makeshift"
" Sleuth automatically changes the indent settings based on files of the same
" type around and above your current file.
NeoBundle "tpope/vim-sleuth"

" Close buffers without changing the layout.
NeoBundle "moll/vim-bbye"

" Handy bracket-prefixed pairs of mappings that @tpope finds useful.
NeoBundle "tpope/vim-unimpaired"

" Hardtime sets a timeout to break bad Vim habits (such as spamming 'j' and
" 'k').
NeoBundle "takac/vim-hardtime"
" Hardmode disables characterwise/'easy' navigation keys, forcing you to master
" Vim's advanced movement keys.
NeoBundle "wikitopian/hardmode"

" Fix terminal key sequences.
NeoBundle "drmikehenry/vim-fixkey"
" Let Tmux notify Vim of changed environmental variables.
NeoBundle 'buztard/vim-nomad'

" Show markers for indents.
NeoBundle "Yggdroot/indentLine"
" View CSS colors.
NeoBundle "gorodinskiy/vim-coloresque"

"
" Editing
"

" Commentary adds key bindings to easily comment and uncomment code.
NeoBundle "tpope/vim-commentary"
" Align text with verbs!
NeoBundle "tommcdo/vim-lion"

" Surround.vim adds support for manipulating the surroundings of a text object,
" such as adding/removing quotes, replacing in brackets, and more.
NeoBundle "tpope/vim-surround"
" Automatically close quotes, parenthesis, braces, and other delimiters.
NeoBundle "Raimondi/delimitMate"
" Automatically end block constructs in supported languages.
NeoBundle "tpope/vim-endwise"

" A Vim implementation of Emac's 'kill ring', allowing you to cycle through
" past pastes.
NeoBundle "maxbrunsfeld/vim-yankstack"
" Force a paste mode regardless of the yank type.
NeoBundle "UnconditionalPaste"

" Split and join statements intelligently.
NeoBundle "AndrewRadev/splitjoin.vim"

" Speeddating adds support for incrementing and decrementing dates.
NeoBundle "tpope/vim-speeddating"

" A better /...
NeoBundle "junegunn/vim-oblique"
" EasyMotion displays possible motions as hints, making it easier to navigate
" files.
NeoBundle "Lokaltog/vim-easymotion"
" Seek adds a two-character seek binding.
NeoBundle "goldfeld/vim-seek"

"
" Search/Substitutions
"

" A fuzzy file-finder, mru switcher, buffer finder, and more (with a nice
" collection of plugins), written in pure VimL.
NeoBundle "kien/ctrlp.vim"
" Ag is a drop-in replacement for Ack, which itself is a grep replacement
" tailored for programmers.
NeoBundle "rking/ag.vim"

" Abolish brings bracket substitutions to Vim abbreviations, searches, and
" substitutions.
NeoBundle "tpope/vim-abolish"

"
" Utilities
"

" Syntastic adds syntax checking for most languages, and linting for the very
" popular ones.
NeoBundle "scrooloose/syntastic"

" Airline is a Powerline-like status bar.
NeoBundle "bling/vim-airline"

" A startup screen for Vim.
NeoBundle "mhinz/vim-startify"
" A Textmate-like 'project drawer' for Vim.
NeoBundle "scrooloose/nerdtree"
" A ctags browser as a sidebar.
NeoBundle "majutsushi/tagbar"
" A tree-like visualization of undo branches.
NeoBundle "mbbill/undotree"

" A better netrw...
NeoBundle "tpope/vim-vinegar"

" Signature.vim adds visual marks in the gutter, as well as shortcuts for
" managing marks.
NeoBundle "kshenoy/vim-signature"
" Signify adds diff marks to the gutter.
NeoBundle "airblade/vim-gitgutter"

" Various utilities for *nix (and maybe Windows) systems, such as renaming and
" deleting files, or changing file permissions.
NeoBundle "tpope/vim-eunuch"

"
" Completion/Snippets
"

" YouCompleteMe is a context-aware completer, with a Python API.  It ships with
" support for C-like languages, and standard Vim omnifuncs.
NeoBundle "Valloric/YouCompleteMe", {"build": {"unix": "sh install.sh --clang-completer --system-libclang"}}

" A powerful snippet engine, with support for nested snippets.
NeoBundle "SirVer/ultisnips"
" A snippets collection for Snipmate/UltiSnips.
NeoBundle "honza/vim-snippets"

"
" Support Files/Integration
"

" A combination of common syntax and support files.
NeoBundle "sheerun/vim-polyglot"

" Bundler, the Ruby dependency manager.
NeoBundle "tpope/vim-bundler"
" A Fugitive extension to browse commits (basically gitk).
NeoBundle "int3/vim-extradite"
" Fish is a non-POSIX compatible shell for the 21st century.
NeoBundle "dag/vim-fish"
" A Git wrapper so awesome, it should be illegal.  Add mappings for working
" with Git meta-files and diffs, and wrap common Git commands.
NeoBundle "tpope/vim-fugitive"
" GnuPG support in Vim.
NeoBundle "jamessan/vim-gnupg"
" A Heroku wrapper, so you can Heroku your Herokus.
NeoBundle "tpope/vim-heroku"
" A Fugitive extension to manage and merge/rebase branches.
NeoBundle "idanarye/vim-merginal"
" Tools for working with Node.js.
NeoBundle "moll/vim-node"
" Tools for working with Ruby on Rails.
NeoBundle "tpope/vim-rails"
" Basic Tmux integration for Vim.
NeoBundle "tpope/vim-tbone"
" Tmux statusline.
NeoBundle "edkolev/tmuxline.vim"
" Tools for working with virtualenv.
NeoBundle "jmcantrell/vim-virtualenv"

"
" Colors
"

" A gorgeous color scheme with light and dark variants.
NeoBundle "altercation/vim-colors-solarized"


" Activate!
NeoBundleCheck
