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
# set to -1 for infinite
HISTSIZE=-1
HISTFILESIZE=-1

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# disable the default virtualenv prompt change
export VIRTUAL_ENV_DISABLE_PROMPT=1
venv() {
    if [[ $VIRTUAL_ENV == *"def"* ]]; then
        echo ""
    else
        [[ -n "$VIRTUAL_ENV" ]] && echo "${VIRTUAL_ENV##*/} " | awk '{print substr($0,0,3)" "}'
    fi
}

branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'
}

ptex() {
    echo $1.tex | entr -s "pdflatex --synctex=1 $1.tex && xdg-open $1.pdf"
}
export -f ptex

PS1='\[\e[38;5;250m\]$(venv)\[\e[38;5;173m\]$(branch)\[\e[1;34m\]\w\[\e[m\] '

alias ls='ls --color=auto'
alias ll='ls -lhS'
alias la='ls -A'
alias l='ls -CF'
alias lg='git ls-files'

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

# NPM install global to userdir
#NPM_PACKAGES="${HOME}/.npm-packages"
#export PATH="$PATH:$NPM_PACKAGES/bin"
# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
#export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

# Fuzzy search
[ -f ~/.config/fzf-bindings.bash ] && source ~/.config/fzf-bindings.bash
export FZF_CTRL_T_COMMAND='find .'

# Don't echo ^C
stty -ctlecho

# Set any Neovim as editor
EDITOR=/usr/bin/nvim
export EDITOR=/usr/bin/nvim

# Enable recursive *'ing
shopt -s globstar

# pyenv
export PATH="/home/chris/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
pyenv virtualenvwrapper

# Custom aliases
alias ..='cd ..'
alias ...='cd ../..'
alias dotfiles='/usr/bin/git --git-dir=/home/chris/.dotfiles/ --work-tree=/home/chris'
#bind '"\C-r": reverse-search-history'
alias o='xdg-open 2>/dev/null'
#alias dropbox='dropbox.py'
#alias smux='/home/chris/Code/scripts/tmux-side.sh'
alias power='echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'
alias powercheck='cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor'
alias jup='python -m jupyter lab --LabApp.token=""'
alias rgp='rg -tpy'
alias rgi='rg -g "*.py" -g "*.ipynb"'
alias python='python3'
#alias wifi='nmcli -c yes dev wifi | head -n 10'
#alias up='nmcli con up id'
alias space='du -h | sort -hr | less'
alias c=/home/$USER/bin/calculon.py
alias grep=rg
alias caff=/home/chris/bin/caffeine.sh

alias aud='/home/chris/bin/switch-audio2.sh'

alias m2d='c [1/100000]x'
alias d2m='c 100000x'

alias fd=fdfind

#alias md='python -m markdown'
#alias mdi='md index.md > index.html'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

ddg ()
{
  /usr/bin/w3m "https://duckduckgo.com/lite?q=$*&kd=-1"
}

export GDAL_DATA=/home/chris/.pyenv/versions/3.7.8/lib/python3.7/site-packages/fiona/gdal_data/
