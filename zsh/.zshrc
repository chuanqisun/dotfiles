# FZF default search should include dot files
# https://github.com/junegunn/fzf/issues/634
export FZF_DEFAULT_COMMAND="rg --files --follow --no-ignore-vcs --hidden -g '!{**/node_modules/*,**/.git/*}'"


# Allow dynamic command prompt
setopt prompt_subst

# Prompt
# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{yellow}%3~ # %f%b'
RPROMPT='%${vcs_info_msg_0_}'

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


