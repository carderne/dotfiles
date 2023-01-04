# zsh settings
setopt AUTO_CD
setopt NO_CASE_GLOB
setopt CORRECT
setopt CORRECT_ALL
autoload -Uz compinit && compinit

# GNU sed
path+=/opt/homebrew/opt/gnu-sed/libexec/gnubin

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b)'
setopt PROMPT_SUBST
PROMPT='%F{green}${vcs_info_msg_0_} %F{blue}${PWD/#$HOME/~}%F{reset} '

# Editor
export EDITOR=/opt/homebrew/bin/nvim

# Vim keybindings in terminal
bindkey -v
# avoid the annoying backspace/delete issue 
# where backspace stops deleting characters
bindkey -v '^?' backward-delete-char

# Gcloud
. /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
. /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

# kubectl
source <(kubectl completion zsh)
source <(kubectl completion zsh | sed s/kubectl/k/g)

# Terraform
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Find and replace
rgr() {( set -e
    git status
    files=$(rg -l "$1")
    echo $files | xargs sed -i "s/$1/$2/g"
    git diff $files
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
}

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
alias jup='~/.pyenv/shims/python -m jupyter lab  --notebook-dir ~'
alias rgp='rg -tpy'
alias space='du -h | sort -hr | less'

alias g='git'
alias p='pnpm'
alias px='pnpm dlx'
alias k=kubectl
