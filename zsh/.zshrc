# only check zcompdump once a day to improve startup time
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
    compinit
done
compinit -C

# Initialize colors for prompt
autoload -U colors && colors

# Path to your oh-my-zsh installation.
DISABLE_MAGIC_FUNCTIONS=true
export ZSH=$HOME/.oh-my-zsh
export DOTFILES=$HOME/.dotfiles

ZSH_THEME="robbyrussell"

plugins=(git tmux zsh-autosuggestions)

ZSH_TMUX_AUTOSTART=true

# extended pattern matching
setopt extendedglob

source $ZSH/oh-my-zsh.sh

PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+=' %{$fg[green]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[yellow]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[yellow]%})"

export GIT_PAGER=

# change python version as needed
# easier than fiddeling with default system version and breaking stuff
alias python="python3"
alias pip="python -m pip"

alias ls="ls -A --color=auto"

# shortcuts 
alias actv="source .venv/bin/activate"


alias o="cd /mnt/c/vault"

# nvm install
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

# add stuff to path
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# add dotfile scripts to path
export PATH="$HOME/.dotfiles/scripts:$PATH"

# export PATH="/mnt/c/Windows/system32:$PATH"
 
# copilot aliases
# eval "$(github-copilot-cli alias -- "$0")"

# modular (mojo)
export MODULAR_HOME="$HOME/mokronos/.modular"
export PATH="$HOME/.modular/pkg/packages.modular.com_mojo/bin:$PATH"

# make ctrl-p act like up arrow (take typed text into account)
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^P" up-line-or-beginning-search # Up
bindkey "^N" down-line-or-beginning-search # Down

# cuda paths
export PATH="/usr/local/cuda-12.4/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda-12.4/lib64:$LD_LIBRARY_PATH"
export PATH="/usr/lib/wsl/lib/:$PATH"

# pnpm
export PNPM_HOME="/home/mokronos/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bun completions
[ -s "/home/mokronos/.bun/_bun" ] && source "/home/mokronos/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opencode
export PATH=/home/mokronos/.opencode/bin:$PATH
export PATH="$PATH:/home/mokronos/google-home-cli"
