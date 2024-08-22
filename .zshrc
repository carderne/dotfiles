# zsh settings
setopt AUTO_CD
setopt NO_CASE_GLOB
#setopt CORRECT
#setopt CORRECT_ALL
autoload -Uz compinit && compinit
# cdpath=($HOME $HOME/tl/app/apps $HOME/tl/services)

# History
export HISTFILE="$HOME/.history"
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

# PATH
## Postgres
path+=('/opt/homebrew/opt/libpq/bin')
path+=('/opt/homebrew/opt/postgresql@15/bin')
## Cargo
path+=('/home/chris/.cargo/bin')
## Go
path+=('/usr/local/go/bin')

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'
setopt PROMPT_SUBST
PROMPT='%F{green}${vcs_info_msg_0_} %F{blue}${PWD/#$HOME/~}%F{reset} '

# Editor
export EDITOR=/opt/homebrew/bin/nvim

# Terraform
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/config

# Python
venv () {
  python -m venv .venv
  echo -e "[env]\n_.python.venv='.venv'" > .mise.toml
  mise trust --quiet
}
alias pydeps='pip install -r ~/.default-python-packages'

# Find and replace
rgr() {( set -e
    git status > /dev/null
    files=$(rg -l "$1")
    echo $files | xargs sed -i '' "s|$1|$2|g"
)}

# Directory browsing
t () {
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
alias v='vi .'
alias vimdiff='nvim -d'

alias o='open'

alias jup='python -m jupyter lab --port=9999 --notebook-dir ~'

alias rg="\rg --ignore-file ~/.config/ripgrep/ignore"
alias rgp='rg -tpy'
alias space='du -h | sort -hr | less'

alias g='git'
alias gb='git branch --sort=-committerdate --color=always | head -8'
alias k=kubectl

alias s="kitten ssh"

# Go
export GOPATH="$HOME/.go"

# Mise

# Cd
cd c 2>/dev/null

ptex() {
   echo $1.tex | entr -s "pdflatex --synctex=1 $1.tex && open $1.pdf"
}

# OS-specific
case `uname` in
  Darwin)
    eval "$(mise activate zsh)"
  ;;
  Linux)
    eval "$(~/.local/bin/mise activate zsh)"
    alias trash='gio trash'
    PROMPT='%F{green}${vcs_info_msg_0_} %F{blue}box${PWD/#$HOME/~}%F{reset} '
    rgr() {( set -e
      git status > /dev/null
      files=$(rg -l "$1")
      echo $files | xargs sed -i "s|$1|$2|g"
    )}
    alias fd=fdfind
  ;;
esac
