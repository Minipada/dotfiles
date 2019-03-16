# Path to your oh-my-zsh installation.
  export ZSH=/home/david/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="superkolo"

plugins=(git colorize autojump copydir kubectl)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

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
alias 'pj'="rosrun plotjuggler PlotJuggler"
alias "gitst"="git status --column"
alias "gitcp"="git cherry-pick"
alias git_colored_commits="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Color grep
export GREP_COLOR=31
alias grep='grep --color=auto'
 
# default editor is vim
export EDITOR=/usr/bin/vim
  
# History
HISTFILE=~/.history
HISTSIZE=1000000
SAVEHIST=1000000
export HISTFILE SAVEHIST

export ROS_IP="$(ip a | grep wlp | grep inet | awk '{ print $2}' | sed "s|/.*||g")"

alias vim='nocorrect vim' 
alias make='nocorrect make'
alias gitkraken='nocorrect gitkraken'
source $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

webmTOmp4 () {
  ffmpeg -i "$1".webm -qscale 0 "$1".mp4
}    
mp4TOmp3 () {
  ffmpeg -i "$1".mp4 "$1".mp3
}


largest () {
  du -a $1 | sort -n -r | head -n $2
}

# remove exited containers:
docker_clean_exited () {
  docker ps --filter status=dead --filter status=exited -aq | xargs -r docker rm -v
}

# remove unused images:
docker_clean_unused_images () {
  docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs -r docker rmi
}

# remove unused volumes
docker_clean_unused_volumes () {
  sudo find '/var/lib/docker/volumes/' -mindepth 1 -maxdepth 1 -type d | grep -vFf <(docker ps -aq | xargs docker inspect | jq -r '.[] | .Mounts | .[] | .Name | select(.)') | xargs -r rm -fr
}

docker_cleanall () {
  docker_clean_exited
  docker_clean_unused_images
  docker_clean_unused_volumes
} 

source $HOME/.aliases

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

remove_containers() {
  docker stop $(docker ps -aq)
  docker rm $(docker ps -aq)
}

armaggedon() {
  removecontainers
  docker network prune -f
  docker rmi -f $(docker images --filter dangling=true -qa)
  docker volume rm $(docker volume ls --filter dangling=true -q)
  docker rmi -f $(docker images -qa)
}

source <(awless completion zsh)
source <(kubectl completion zsh)
source <(kops completion zsh)

# ansible
export PYTHONPATH=/usr/lib/python3/dist-packages/
source /opt/ros/melodic/setup.zsh
export PATH=$PATH:~/.jx/bin

