# Custom theme based on robbyrussell
# Created by galpolak

# Function to count modified files
function git_modified_files_count() {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    local count=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
    if [[ $count -gt 0 ]]; then
      echo "%{$fg[yellow]%}[$count]%{$reset_color%}"
    fi
  fi
}

# Enable command substitution in prompts
setopt prompt_subst

# Function to render the first line with git on the right
function prompt_first_line() {
  # Capture exit status early before it changes
  local exit_status=$?

  local arrow_color
  if [[ $exit_status -eq 0 ]]; then
    arrow_color="%{$fg_bold[green]%}"
  else
    arrow_color="%{$fg_bold[red]%}"
  fi

  local left="${arrow_color}➜ %{$reset_color%}%{$fg[cyan]%}%c%{$reset_color%}"
  local right="$(_omz_git_prompt_info)$(git_modified_files_count)"

  # Strip color codes to calculate actual string length
  local left_plain="${(S%%)left//\%\{*\%\}}"
  local right_plain="${(S%%)right//\%\{*\%\}}"

  local left_len=${#left_plain}
  local right_len=${#right_plain}

  # Calculate spacing
  local spacing=$((COLUMNS - left_len - right_len))

  local second_line_arrow="${arrow_color}➜ %{$reset_color%}"

  if [[ $spacing -gt 0 && -n $right_plain ]]; then
    print -P "${left}${(l:${spacing}:: :)}${right}"
    print -P "${second_line_arrow}"
  else
    print -P "${left}"
    print -P "${second_line_arrow}"
  fi
}

# Hook function to display divider after command execution
function precmd() {
  # Draw a cyan horizontal line
  print -P "%{$fg[cyan]%}${(l:$COLUMNS::⎯:)}%{$reset_color%}"
}

# Hook function to display divider before command output
function preexec() {
  # Draw a light grey horizontal line before command output (using bright black/grey)
  print -P "%{$fg_bold[black]%}${(l:$COLUMNS::⎯:)}%{$reset_color%}"
}

# Main prompt
PROMPT='$(prompt_first_line)'

# Clear right prompt
RPROMPT=''

# Git prompt settings
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✎%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
