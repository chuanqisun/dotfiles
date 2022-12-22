# FZF default search should include dot files
# https://github.com/junegunn/fzf/issues/634
export FZF_DEFAULT_COMMAND="rg --files --follow --no-ignore-vcs --hidden -g '!{**/node_modules/*,**/.git/*}'"

### Prompt
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%1~%f%b %# '
RPROMPT='%*'

### Alias
alias ll="ls"
alias ls="ls -alh --color"
alias ..="cd ../"
alias ...="cd ../../"

### History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
