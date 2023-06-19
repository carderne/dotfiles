# zsh settings
setopt AUTO_CD
setopt NO_CASE_GLOB
#setopt CORRECT
#setopt CORRECT_ALL
autoload -Uz compinit && compinit
cdpath=($HOME $HOME/tl/app/apps $HOME/tl/services)

# History
export HISTFILE="$HOME/.history"
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || path+=("$PYENV_ROOT/bin")
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Postgres
path+=('/opt/homebrew/opt/libpq/bin')

# does postgres need to be at the _start_ of PATH?
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# asdf
case `uname` in
  Darwin)
    . /opt/homebrew/opt/asdf/libexec/asdf.sh
  ;;
esac

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'
setopt PROMPT_SUBST
PROMPT='%F{green}${vcs_info_msg_0_} %F{blue}${PWD/#$HOME/~}%F{reset} '

# Editor
export EDITOR=/opt/homebrew/bin/nvim

# Vim keybindings in terminal
#bindkey -v
# avoid the annoying backspace/delete issue 
# where backspace stops deleting characters
#bindkey -v '^?' backward-delete-char

# Open with vim
zle -N edit-file
edit-file () {
  BUFFER="vim $BUFFER"
  zle accept-line "$@"
}
bindkey '\C-k' edit-file

# Gcloud
#. /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
#. /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

# kubectl
#source <(kubectl completion zsh)
#source <(kubectl completion zsh | sed s/kubectl/k/g)

# Terraform
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/config

# Find and replace
rgr() {( set -e
    git status > /dev/null
    files=$(rg -l "$1")
    echo $files | xargs sed -i '' "s|$1|$2|g"
)}

# Directory browsing
function t() {
  local dir;
  while true; do
    # exit with ^D
    dir="$(ls -a1p | grep '/$' | grep -v '^./$' | fzf --height 40% --reverse --no-multi --preview 'pwd' --preview-window=up,1,border-none --no-info)"
    if [[ -z "${dir}" ]]; then
      break
    else
      cd "${dir}"
    fi
  done
  ls
}

# Open rg results in vim
virg() {( set -e
  nvim -o $(rg -l $1)
)}


# Aliases
alias ls='ls --color=auto'
alias ll='ls -lhS'
alias la='ls -A'
alias l='ls -CF'
alias lg='git ls-files'

alias vim='nvim'
alias vi='vim'
alias vimdiff='nvim -d'

alias o='open'
alias jup='~/.pyenv/shims/python -m jupyter lab --port=9999 --notebook-dir ~'
alias rg="\rg --ignore-file ~/.config/ripgrep/ignore"
alias rgp='rg -tpy'
alias space='du -h | sort -hr | less'

alias g='git'
alias p='pnpm'
alias px='pnpm dlx'
alias k=kubectl

# Created by `pipx` on 2023-02-22 10:38:13
export PATH="$PATH:/Users/chris/.local/bin"

case `uname` in
  Darwin)
    export PNPM_HOME="/Users/chris/Library/pnpm"
  ;;
  Linux)
    export PNPM_HOME="/home/chris/.local/share/pnpm"
  ;;
esac
export PATH="$PNPM_HOME:$PATH"

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
