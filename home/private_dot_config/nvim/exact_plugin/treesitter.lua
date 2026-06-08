require('tree-sitter-manager').setup({
  ensure_installed = {
    'awk', 'bash', 'cmake', 'cpp', 'css', 'csv', 'diff',
    'editorconfig', 'fish', 'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore',
    'go', 'gomod', 'gosum', 'gotmpl', 'gowork', 'graphql', 'html',
    'java', 'javadoc', 'javascript', 'jq', 'json', 'jsx', 'lua',
    'luadoc', 'make', 'markdown', 'markdown_inline', 'nginx', 'nix', 'objc',
    'passwd', 'pem', 'perl', 'php', 'phpdoc', 'powershell', 'printf',
    'properties', 'proto', 'python', 'regex', 'rego', 'requirements', 'rst',
    'ruby', 'rust', 'scss', 'sql', 'ssh_config', 'starlark', 'strace',
    'terraform', 'tmux', 'toml', 'typescript', 'udev', 'vim', 'vimdoc',
    'xml', 'yaml', 'zsh',
  },
  auto_install = true,
})
