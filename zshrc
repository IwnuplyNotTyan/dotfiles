# Path
PATH="$HOME/files/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"

# Alias
alias dots="cd ~/files/project/dotfiles"
alias project="cd ~/files/project/"
alias q="exit" # Exit
alias vi="nvim" # Alias
alias r="joshuto" # File Manager
alias fe="fd -e" # FD
alias ftd="fd --type d"
alias e="exa --icons --color=always --reverse" # EXA
alias el="exa --icons --color=always --reverse --git -l --all"
alias et="exa --icons --tree --color=always --reverse"
alias eg="exa --icons --git-ignore --reverse"
alias ed="exa --icons --tree --reverse --color=always --reverse -D"
source ${ZDOTDIR:-~}/.zsh/cd-ls/cd-ls.plugin.zsh # Exa After CD Plugin
CD_LS_COMMAND="exa --icons --color=always --reverse"
alias di="doas dnf5 install" # DNF
alias dr="doas dnf5 remove"
alias du="doas dnf5 update"
alias dce="doas dnf copr enbale"
alias dcd="doas dnf copr disable"
#alias ni="nala install" # Nala & APT
#alias ny="apt update"
#alias nu="nala upgrade"
#alias nr="nala remove"
alias ne="nix-env" # Nix!
alias nei="nix-env -iA"
alias ns="nix-shell"
alias ncl="nix-channel --list"
alias ncu="nix-channel --update"
alias y="yarn" # Yarn
alias yc="yarn create"
alias yd="yarn dev"
alias yb="yarn build"
alias yad="yarn add"
alias yrm="yarn remove"
alias ys="yarn set"

# FZF
export FZF_DEFAULT_COMMAND='fd --type file --follow --exclude .git' # With FD
alias f="fzf --preview 'bat --color=always --style="changes" --line-range=:500 {}'" # With Bat
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border=rounded' # Default Option
#alias d="bash ~/.zsh/fzf/dnf" # https://github.com/junegunn/fzf/wiki/Examples#DNF

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
export NVM_LAZY_LOAD=true
export NVM_NO_USE=true
source ~/.zsh/zsh-nvm/zsh-nvm.plugin.zsh

#Neovim
export VISUAL=nvim;
export EDITOR=nvim;
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim') # NVM Trigger

# AutoPair
source ~/.zsh/zsh-autopair/autopair.zsh
autopair-init
typeset -gA AUTOPAIR_PAIRS
bindkey "<" autopair-insert
AUTOPAIR_PAIRS+=("<" ">")
AUTOPAIR_LBOUNDS=(all '[.:/\!]')
AUTOPAIR_LBOUNDS+=(quotes '[]})a-zA-Z0-9]')
AUTOPAIR_LBOUNDS+=(spaces '[^{([]')
AUTOPAIR_LBOUNDS+=(braces '')
AUTOPAIR_LBOUNDS+=('`' '`')
AUTOPAIR_LBOUNDS+=('"' '"')
AUTOPAIR_LBOUNDS+=("'" "'")
AUTOPAIR_RBOUNDS=(all '[[{(<,.:?/%$!a-zA-Z0-9]')
AUTOPAIR_RBOUNDS+=(quotes '[a-zA-Z0-9]')
AUTOPAIR_RBOUNDS+=(spaces '[^]})]')
AUTOPAIR_RBOUNDS+=(braces '')

# Completions & Shell
autoload -U compinit; compinit
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*' file-list change reverse all
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh # Completion
source ~/.zsh/zsh-cargo-completion/zsh-cargo-completion.plugin.zsh # Cargo Completion
source ~/.zsh/zsh-rustup-completion/rustup.plugin.zsh # Rastup Completion
source ~/.zsh/zsh-yarn-completions/zsh-yarn-completions.plugin.zsh # Yarn Completion
source ~/.zsh/zsh-nix-shell/nix-shell.plugin.zsh # Nix Shell Plugin
source ~/.zsh/nix-zsh-completions/nix-zsh-completions.plugin.zsh # Nix Completion
fpath=(~/.zsh/nix-zsh-completions $fpath)
source ~/.zsh/zsh-better-npm-completion/zsh-better-npm-completion.plugin.zsh
export NVM_COMPLETION=true

# Plugin & Apps
source ~/.zsh/calc.plugin.zsh/calc.plugin.zsh # Calculator
source ~/.zsh/formarks/formarks.plugin.zsh # Marks Directory
source ~/.zsh/copy-pasta/copy-pasta.plugin.zsh # Easy Copy & Pasta
source ~/.zsh/colored-man-pages_mod/colored-man-pages_mod.plugin.zsh # Man With Color
source ~/.zsh/extract/extract.plugin.zsh # Extract
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh # Syntax
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh # Fish-like Autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#cccccc,bg=none,italic,underline"
fpath=($HOME/.zsh/zsh-completions/src $fpath)
eval "$(starship init zsh)" # StarShip!

# Color Scheme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#c5c8c9,bg:#0B0F10,hl:#d7005f
        --color=fg+:#c5c8c9,bg+:#0B0F10,hl+:#d7005f
            --color=info:#87c7a1,prompt:#c5c8c9,pointer:#87c7a1
            --color=marker:#87c7a1,spinner:#87c7a1,header:#87c7a1' # FZF (janegh/dotfiles)

# History
export HISTFILE=~/files/bin/history
export HISTSIZE=1000000
export SAVEHIST=1000000

# Nix Deamon
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
