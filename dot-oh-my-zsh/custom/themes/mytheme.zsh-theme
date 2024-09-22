# Configuration
SHOW_FULL_PATH=0           # 1: Full path, 0: Only current directory
SHOW_MS_THRESHOLD=500      # Show elapsed time in ms if more than this (500ms)
SHOW_SEC_THRESHOLD=10000   # Show elapsed time in sec if more than this (10s)

# Before command execution
preexec() {
  timer_start=$EPOCHREALTIME
}

# After command execution
precmd() {
  ERROR_CODE=$?
  
  if [ $ERROR_CODE -ne 0 ]; then
    ERROR_CODE_MSG="%{$fg[red]%}$ERROR_CODE ↵%{$reset_color%}"
  else
    ERROR_CODE_MSG=""
  fi

  if [[ -n "$timer_start" ]]; then
    elapsed_time_ms=$(( ($EPOCHREALTIME - $timer_start) * 1000.0 ))

    # If elapsed more than 10 seconds, show in seconds
    # Else if elapsed more than 500ms, show in ms
    if (( ${elapsed_time_ms%.*} < $SHOW_MS_THRESHOLD )); then
      ELAPSED_TIME_MSG=""
    elif (( ${elapsed_time_ms%.*} < $SHOW_SEC_THRESHOLD )); then
      ELAPSED_TIME_MSG="  %{$fg[cyan]%}${elapsed_time_ms%.*}ms%{$reset_color%} "
    else
      time_sec=$(( ${elapsed_time_ms%.*} / 1000 ))
      ELAPSED_TIME_MSG="  %{$fg[cyan]%}${time_sec}s%{$reset_color%} "
    fi
    timer_start=""

  else
    # No command was run, (first prompt, just enter, ctrl+c, etc)
    ELAPSED_TIME_MSG=""
    ERROR_CODE_MSG=""
  fi

  RPROMPT="${ERROR_CODE_MSG}${ELAPSED_TIME_MSG}"
}

if [ $SHOW_FULL_PATH -eq 1 ]; then
  PATH_PROMPT='%~'
else
  PATH_PROMPT='%c'
fi

PROMPT='%{$fg[cyan]%}${PATH_PROMPT}%{$reset_color%} $(ruby_prompt_info)$(git_prompt_info)%{$reset_color%}%B>%b '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=") %{$reset_color%}"

ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg[red]%}("
ZSH_THEME_RUBY_PROMPT_SUFFIX=") %{$reset_color%}"
