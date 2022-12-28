# FZF default search should include dot files
# https://github.com/junegunn/fzf/issues/634
export FZF_DEFAULT_COMMAND="rg --files --follow --no-ignore-vcs --hidden -g '!{**/node_modules/*,**/.git/*}'"

### ENV
export VISUAL="nvim"
export EDITOR="nvim"

# Allow dynamic command prompt
setopt prompt_subst

# Automatic `cd` prefix to directory
setopt auto_cd

# Prompt
# Load version control information
autoload -Uz vcs_info

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       ' (%b%u%c)'
zstyle ':vcs_info:git:*' actionformats ' (%b|%a%u%c)'

precmd() { vcs_info }


PROMPT='%(?.%F{green}%?.%F{red}%?)%f %B%F{yellow}%3~%F{cyan}${vcs_info_msg_0_}%f%F{yellow} %# %f%b'
#RPROMPT='%F{red}${vcs_info_msg_0_}%f'


### Alias
alias ll="ls"
alias ls="ls -alh --color"
alias ..="../"
alias ...="../../"

### History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory



### Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
