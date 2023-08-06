# Link
PATH="$HOME/files/scripts:$PATH"

# Basic
alias r="ranger"

# DNF (REQ DNF)
alias du="sudo dnf5 update"
alias di="sudo dnf5 install"
alias d="bash ~/script/dnf" # https://github.com/junegunn/fzf/wiki/Examples#DNF

#FlatPak (REQ FLATPAK)
#alias fp="bash ~/script/flatpak" # https://github.com/junegunn/fzf/wiki/Examples#flatpak

# Nala (REQ NALA)
#alias ny="nala update"
#alias nu="nala upgrade"
#alias ni="nala install"
#alias nr="nala remove"

# Yarn (REQ YARN)
alias y="yarn"
alias yc="yarn create"
alias yd="yarn dev"
alias yb="yarn build"
alias yad="yarn add"
alias yrm="yarn remove"
alias ys="yarn set"

# Script
alias blocks="bash ~/files/scripts/blocks" # Scripts
alias panels="bash ~/files/script/panels"
alias fet="bash ~/files/scripts/fet/"
alias bunnyfetch="bash ~/files/scripts/bunnyfetch"

# FZF (REQ FZF (Install With GIT) & BAT)
if [[ ! "$PATH" == */home/q/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/q/.fzf/bin"
fi
[[ $- == *i* ]] && source "/data/data/com.termux/files/home/.fzf/shell/completion.zsh" 2> /dev/null # Auto Completion
source "/home/q/.fzf/shell/key-bindings.zsh" # Key Bind
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border' # Default Option
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#c5c8c9,bg:#0B0F10,hl:#d7005f
        --color=fg+:#c5c8c9,bg+:#0B0F10,hl+:#d7005f
            --color=info:#87c7a1,prompt:#c5c8c9,pointer:#87c7a1
            --color=marker:#87c7a1,spinner:#87c7a1,header:#87c7a1' # Color Scheme (janegh/dotfiles)
alias f="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"

#Neovim (REQ)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
export VISUAL=nvim;
export EDITOR=nvim;
alias n="nvim" # Alias

# Plugin (REQ OMZ)
plugins=(
                git
                command-not-found
                colored-man-pages
)

# OMZ (REQ)
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# StarShip! (REQ)
eval "$(starship init zsh)"
