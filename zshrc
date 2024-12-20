export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export HISTFILE="$XDG_STATE_HOME/zsh/history"

ZSH_THEME="mytheme"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# ENABLE_CORRECTION="true"
unsetopt correct_all  
setopt correct

zstyle ':omz:update' mode auto
# zstyle ':omz:update' frequency 13

plugins=(git colored-man-pages fancy-ctrl-z)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export ZSH_COMPDUMP="$ZSH/cache/.zcompdump-$HOST"
export JAVA_HOME="/usr/lib/jvm/default-runtime"

source $ZSH/oh-my-zsh.sh

eval "`fnm env`"

find() {
  command find "$@" 2> >(grep -v 'Permission denied' >&2)
}

link-contents() {
  if [ ! -d $1 ]; then
    echo "Directory not found: $1"
    return 1
  fi
  for file in $1/*; do
    ln -s $file $2
  done
}

alias open="xdg-open"
alias zshconfig="open $HOME/.zshrc"
alias zshreload="source $HOME/.zshrc"
alias cat="bat"
alias top="htop"
alias cdesk="cd ~/Desktop"

run_remote="$HOME/bin/hooks/sync-projects/run-remote.sh"
alias regenerate-front="$run_remote local/e2e.sh"
alias regenerate-back="$run_remote local/e2eBack.sh"
alias regenerate-db="$run_remote local/regenerateDB.sh"
alias populate-front="$run_remote local/simpleE2e.sh"
alias populate-back="$run_remote local/simpleBackE2e.sh"
alias truncate-tenant="$run_remote ~/bin/truncate-tenant"
alias flyway-migrate="$run_remote ~/bin/flyway-migrate"
alias mongo-migrate="$run_remote local/scripts/mongo-migration.sh"
