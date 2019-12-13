# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=10000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# disable the default virtualenv prompt change
export VIRTUAL_ENV_DISABLE_PROMPT=1
venv() {
    if [[ $VIRTUAL_ENV == *"scratch"* ]]; then
        echo ""
    else
        [[ -n "$VIRTUAL_ENV" ]] && echo "${VIRTUAL_ENV##*/} " | awk '{print substr($0,0,3)" "}'
    fi
}


branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /' | awk '{print substr($0,0,3)" "}'
}

PS1='\[\e[38;5;250m\]$(venv)\[\e[38;5;173m\]$(branch)\[\e[1;34m\]\w\[\e[m\] '

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

PATH=$PATH:~/.local/bin

# Remove Downloads directory if it appears
rm -rf ~/Downloads/ || true

# Install Ruby Gems to ~/gems
export GEM_HOME=$HOME/.gems
export PATH=$HOME/.gems/bin:$PATH

# Virtualenvwrapper
export WORKON_HOME=$HOME/.envs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /home/chris/.local/bin/virtualenvwrapper.sh
workon scratch

# Fuzzy search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Don't echo ^C
stty -ctlecho

# Set any vi variant as editor
EDITOR=vi

# Custom aliases
alias ..='cd ..'
alias dotfiles='/usr/bin/git --git-dir=/home/chris/.dotfiles/ --work-tree=/home/chris'
bind '"\C-r": reverse-search-history'
alias o='xdg-open 2>/dev/null'
alias dropbox='dropbox.py'
alias smux='/home/chris/Code/scripts/tmux-side.sh'
alias ptex='pdflatex --synctex=1'
#alias power='sudo cpupower frequency-set --governor performance'
alias power='sudo echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'
alias powercheck='cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'
alias jup='python -m jupyter notebook'
alias sshaws='ssh ec2-3-93-220-46.compute-1.amazonaws.com'
alias rgp='rg -tpy'
alias python='python3'
alias c='calc'
