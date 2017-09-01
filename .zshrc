# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.zsh-themes
ZSH_THEME="bullet-train"
BULLETTRAIN_DIR_BG='15'
BULLETTRAIN_DIR_FG='black'
BULLETTRAIN_GIT_BG='8'
BULLETTRAIN_GIT_FG='white'
BULLETTRAIN_STATUS_BG='cyan'
BULLETTRAIN_STATUS_FG='default'
BULLETTRAIN_GIT_UNTRACKED="%F{yellow} +%F{black}"
BULLETTRAIN_GIT_AHEAD="%F{15} ⬆"
BULLETTRAIN_GIT_BEHIND="%F{15} ⬇"
BULLETTRAIN_GIT_DIVERGED="%F{15} ⬍"
BULLETTRAIN_GIT_RENAMED="%F{15} ➜"
BULLETTRAIN_PROMPT_SEPARATE_LINE='false'
BULLETTRAIN_PROMPT_ORDER=(
  context
  dir
  git
  status
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$PATH:$HOME/.composer/vendor/bin"

#additions as per drbunsen.org
export EDITOR="nvim"
bindkey -v

# vi style incremental search
# bindkey '^R' history-incremental-search-backward
# bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

setopt AUTO_CD

alias l='ls -alhF'
alias lvr='ls -alR > /dev/null'
alias uas='cd ~/Documents/Work/UofA/scholarships/ua-scholarships6/'
alias arop='cd ~/Documents/Work/UofA/arop/vms/ua-arop2/'
alias ccsp='cd ~/Documents/Work/UofA/ccsp/vms/ua-ccsp'
alias bd='cd ~/Documents/Work/UofA/bank_details/vms/ua-bank-details-1/'
alias docs='cd ~/Documents/Work/UofA/ua-docs/vms/ua-docs/'
alias sys='cd ~/Documents/Work/internal/vms/sys/'
alias cusoon='cd ~/Documents/Work/jubn_cusoon/vms/cusoon'
alias e='exa -algB'

alias uakeys='ssh-add ~/.ssh/uofa/keys/ua_lamp_docker/id_rsa && ssh-add ~/.ssh/uofa/keys/jenkins_deployment_key/id_rsa'
alias ecd='~/Eclipse.app/Contents/Eclipse/eclimd'

# nvim aliases
alias nv='nvim'
alias v='nvim'
alias -s php=nvim
alias -s module=nvim
alias -s scss=nvim
alias -s css=nvim
alias -s tpl=nvim
alias -s yml=nvim

# git aliases
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gl='git log'
alias gffp='git flow feature publish'
alias gfff='git flow feature finish'

# tmux aliases
alias tmuxd='~/.config/tmux/drupal.sh'
alias tmuxs='~/.config/tmux/split.sh'
alias ta='tmux attach -t'
alias tl='tmux ls'

# vagrant exec binstubs
alias rb='vbin/robo'
# alias dr='vbin/drush'
alias dc='vbin/drupal'
alias vs='vagrant ssh'
alias co='vbin/codecept'

alias wallissh='ssh -p 2223 root@103.21.48.192'
alias redyssh='ssh theoryz4@122.129.219.79 -p 2022 -i id_dsa'

alias de='eval $(docker-machine env default)'

alias ..='cd ..'

find-up () {
  SWD=$(pwd)
  while [[ $PWD != / ]] ; do
    find "$PWD" -maxdepth 1 -name "$@"
    cd ..
  done
  cd $SWD
}

run-drush () {
  ssh -F .vagrant/ssh_config -q -t default "bash -l -c 'cd /vagrant/app && /home/vagrant/.composer/vendor/bin/drush $@'"
}

alias dr2='run-drush'

# add in looking for the command down the tree...
# the idea begin:
# use the vbin version if it exists, or
# if in Vagrant directory do vagrant ssh -c, or
# run it if command, or
# throw error
vbb () {
  if [ -f vbin/$1 ]
  then
    vbin/$1
  elif [ -f Vagrantfile ]
  then
    vagrant ssh -c "cd /vagrant && $1 ${@:2}"
  else
    echo "echo"
  fi
}

alias dr='vbb bin/drush -r app'

# function to toggle fg/bg on control z
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

stty start undef stop undef

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# setup fasd
eval "$(fasd --init auto)"

# fasd z replacement using fzf
z() {
  local dir
  dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

export PATH="/usr/local/opt/ncurses/bin:$PATH"
