# Configuration
SHOW_FULL_PATH=0        # 1: Full path, 0: Only current directory
SHOW_MS_THRESHOLD=0.5   # Show elapsed time in ms if more than this (500ms)
SHOW_SEC_THRESHOLD=10   # Show elapsed time in sec if more than this (10s)

# Before command execution
preexec() {
  timer_start=$EPOCHREALTIME
}

# After command execution
precmd() {
  ERROR_CODE=$?

  if [[ -z "$timer_start" ]]; then
    # No command was run, (first prompt, just enter, ctrl+c, etc)
    return
  fi

  elapsed_time=$(($EPOCHREALTIME - $timer_start))
  timer_start=""

  if [ $ERROR_CODE -eq 0 ] && (( $elapsed_time < $SHOW_MS_THRESHOLD )); then
    return
  fi

  print -n '['

  if [ $ERROR_CODE -ne 0 ]; then
    print -n " $fg[red]$ERROR_CODE ↵$reset_color "
  fi

  if (( $elapsed_time >= $SHOW_SEC_THRESHOLD )); then
    print -n " $fg[cyan]${elapsed_time%.*}s$reset_color "
  elif (( $elapsed_time >= $SHOW_MS_THRESHOLD )); then
    elapsed_time_ms=$(($elapsed_time * 1000))
    print -n " $fg[cyan]${elapsed_time_ms%.*}ms$reset_color "
  fi

  print ']'
}

if [ $SHOW_FULL_PATH -eq 1 ]; then
  PATH_PROMPT='%~'
else
  PATH_PROMPT='%c'
fi

PROMPT='%{$fg[cyan]%}${PATH_PROMPT}%{$reset_color%} %B>%b '
RPROMPT='$(ruby_prompt_info)$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"

ZSH_THEME_RUBY_PROMPT_PREFIX=" %{$fg[red]%}("
ZSH_THEME_RUBY_PROMPT_SUFFIX=")%{$reset_color%}"
