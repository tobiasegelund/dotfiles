# eval "$(/opt/homebrew/bin/brew shellenv)"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
ZSH_PYENV_QUIET=true

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell" # apple / robbyrussell

zstyle ':omz:update' mode auto      # update automatically without asking
# CASE_SENSITIVE="true"
DISABLE_LS_COLORS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  git
  brew
  pyenv
  fzf
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

typeset -U path
path=(
  /usr/local/{bin,sbin}
  $HOME/.cargo/bin
  $HOME/.local/bin
  $path
)

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

alias zshrc="vi ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"

# GIT
alias ga="git add"
alias gc="git commit"
alias gs="git status"
alias gd="git diff"
alias gb="git branch"
alias gp="git push"
alias gm="git checkout master"
alias gl="git log --oneline --decorate"

# ENV
alias ae='deactivate &> /dev/null; source ./.venv/bin/activate'
alias de='deactivate'

# BASH
alias la='ls -l'
alias lah='ls -lah'
alias path='echo -e ${PATH//:/\\n}'

# NAVIGATE
alias ..="cd .."

export FZF_COMPLETION_OPTS='--border --info=inline'

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}
