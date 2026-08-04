# Initialize colors for prompt
autoload -U colors && colors

# Path to your oh-my-zsh installation.
DISABLE_MAGIC_FUNCTIONS=true
export ZSH=$HOME/.oh-my-zsh
export DOTFILES=$HOME/.dotfiles

ZSH_THEME="robbyrussell"

plugins=(git tmux zsh-autosuggestions)

ZSH_TMUX_AUTOSTART=false

# User-managed completions, including Docker Desktop's generated completion.
fpath=("$HOME/.zsh/completions" $fpath)

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
export NVM_SYMLINK_CURRENT=true
export PATH="$NVM_DIR/current/bin:$PATH"
_load_nvm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}

for _nvm_command in nvm node npm npx; do
    eval "${_nvm_command}() { _load_nvm; ${_nvm_command} \"\$@\"; }"
done
unset _nvm_command

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
export OPENCODE_DISABLE_CLAUDE_CODE=1
export PATH="$PATH:/home/mokronos/google-home-cli"

# Disable Bun AI agent rule file generation
export BUN_AGENT_RULE_DISABLED=1
export CLAUDE_CODE_AGENT_RULE_DISABLED=1

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

# Pi
export PATH="/home/mokronos/.local/share/mise/installs/node/25.2.1/bin:$PATH"

# Keep Herdr tab names in sync with the foreground process.
for _f in ${HOME}/.config/herdr/plugins/github/herdr-automatic-rename-*/shell/hook.zsh(N); do
  source $_f
  break
done

# After a reboot, keep resumable agent tabs and at most one stale shell tab per workspace.
_herdr_prune_restored_shells() {
  local session="$HOME/.config/herdr/session.json" tmp
  [[ -f "$session" ]] || return
  command herdr status server >/dev/null 2>&1 && return

  tmp=$(mktemp "${session}.XXXXXX") || return
  if jq '
    .workspaces |= map(
      .active_tab as $active |
      .tabs as $tabs |
      ([range(0; $tabs | length) as $i |
        select($tabs[$i].panes | any(.[]; has("agent_session"))) | $i]) as $agents |
      ([range(0; $tabs | length) as $i |
        select(($tabs[$i].panes | any(.[]; has("agent_session"))) | not) | $i]) as $shells |
      ($shells | if length == 0 then [] elif index($active) != null then [$active] else [.[0]] end) as $kept_shell |
      ($agents + $kept_shell | sort) as $kept |
      .tabs = [$kept[] as $i | $tabs[$i]] |
      .public_tab_numbers = [$kept[] as $i | .public_tab_numbers[$i]] |
      .active_tab = (($kept | index($active)) // 0)
    )
  ' "$session" > "$tmp"; then
    chmod --reference="$session" "$tmp"
    mv "$tmp" "$session"
  else
    rm -f "$tmp"
  fi
}

herdr() {
  (( $# == 0 )) && _herdr_prune_restored_shells
  command herdr "$@"
}
