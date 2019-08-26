# ~/.bashrc: executed by bash(1) for non-login shells.

# Open tmux
terminal=$(ps -o 'cmd=' -p $(ps -o 'ppid=' -p $$) | sed 's/.*\///')
if [ "$terminal" == "gnome-terminal-server" ]; then
    if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
      tmux a -t default || exec tmux new -s default && exit;
    fi
fi

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
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1='\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\e[0;31m\]\]$(parse_git_branch)\[\033[00m\]$ '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

# Remove Downloadsdirectory if it appears
rm -rf ~/Downloads/ || true

# Install Ruby Gems to ~/gems
export GEM_HOME=$HOME/.gems
export PATH=$HOME/.gems/bin:$PATH

# Virtualenvwrapper
export WORKON_HOME=$HOME/.envs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /home/chris/.local/bin/virtualenvwrapper.sh

# Fuzzy search
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Custom aliases
alias ..='cd ..'
alias dotfiles='/usr/bin/git --git-dir=/home/chris/.dotfiles/ --work-tree=/home/chris'
bind '"\C-r": reverse-search-history'
alias o='xdg-open'
alias co='echo "In Bash, use ctrl-w to delete the last word, and ctrl-u to delete the content from current cursor back to the start of the line. Use alt-b and alt-f to move by word, ctrl-a to move cursor to beginning of line, ctrl-e to move cursor to end of line, ctrl-k to kill to the end of the line, ctrl-l to clear the screen. See man readline for all the default keybindings in Bash. There are a lot. For example alt-. cycles through previous arguments, and alt-* expands a glob."'
alias dropbox='dropbox.py'
alias smux='/home/chris/Code/scripts/tmux-side.sh'
alias ptex='pdflatex --synctex=1'
#alias power='sudo cpupower frequency-set --governor performance'
alias power='sudo echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'
alias powercheck='cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'
alias jup='python -m jupyter notebook'
alias sshaws='ssh ec2-3-93-220-46.compute-1.amazonaws.com'
alias rgp='rg -tpy'
