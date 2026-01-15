# only check zcompdump once a day to improve startup time
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
    compinit
done
compinit -C

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

# only needed on windows with wsl
alias explorer="/mnt/c/Windows/explorer.exe ."

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

# ros shell startup script
source /opt/ros/humble/setup.zsh

# colcon autocomplete
source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.zsh
# colcon annoying notifications suppression
export COLCON_EXTENSION_BLOCKLIST=colcon_core.event_handler.desktop_notification

# ugly fix for path problems with windows executables
# this path segment is there sometimes? like when i start fresh
# but then dissapears at some point, not sure when or why
# then explorer.exe or cmd.exe dont work, stuff doesn't work
export PATH="/usr/lib/wsl/lib:/mnt/c/Program Files/WindowsApps/CanonicalGroupLimited.Ubuntu_2204.3.49.0_x64__79rhkp1fndgsc:/mnt/c/Windows/system32:/mnt/c/Windows:/mnt/c/Windows/System32/Wbem:/mnt/c/Windows/System32/WindowsPowerShell/v1.0/:/mnt/c/Windows/System32/OpenSSH/:/mnt/c/Program Files/dotnet/:/mnt/c/Program Files (x86)/NVIDIA Corporation/PhysX/Common:/mnt/c/Users/Sebastian Hirt/AppData/Local/Microsoft/WindowsApps:/mnt/c/Users/Sebastian Hirt/AppData/Local/Programs/Microsoft VS Code/bin:/mnt/c/Users/Sebastian Hirt/AppData/Local/Programs/cursor/resources/app/bin:$PATH"

# cuda fix
export CUDA_HOME=/usr/local/cuda-12.4
export PATH=${CUDA_HOME}/bin:${PATH}
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:$LD_LIBRARY_PATH

# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# bun completions
[ -s "~/.bun/_bun" ] && source "~/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
. "~/.deno/env"
# opencode
export PATH=~/.opencode/bin:$PATH
