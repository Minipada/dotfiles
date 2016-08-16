# Path to your oh-my-zsh installation.
  export ZSH=/home/david/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="kolo"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Colors in man
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
      man "$@"
}

# Autocompletion
autoload -U compinit
compinit
 
# matches case insensitive for lowercase
 zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
  
# Completion cache
  zstyle ':completion:*' use-cache on
  zstyle ':completion:*' cache-path ~/.zsh_cache

# Color completion
zmodload zsh/complist
setopt extendedglob
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
 
# Command correction
setopt correctall
  
autoload colors; colors
   
# Aliases
alias ls='ls --color=auto'
alias ll='ls --color=auto -lh'
alias lll='ls --color=auto -lh | less'
alias xs='cd'
alias sl='ls'
alias df='df -h'
alias cls='clear'
alias 'vi'='vim'
alias 'm'='make'
alias 'mc'='make clean'

# Color grep
export GREP_COLOR=31
alias grep='grep --color=auto'
 
# default editor is vim
export EDITOR=/usr/bin/vim
  
# History
HISTFILE=~/.history
HISTSIZE=1000
SAVEHIST=1000
export HISTFILE SAVEHIST

