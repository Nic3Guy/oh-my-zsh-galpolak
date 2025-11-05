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
  local left="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}%{$fg[cyan]%}%c%{$reset_color%}"
  local right="$(_omz_git_prompt_info)$(git_modified_files_count)"

  # Strip color codes to calculate actual string length
  local left_plain="${(S%%)left//\%\{*\%\}}"
  local right_plain="${(S%%)right//\%\{*\%\}}"

  local left_len=${#left_plain}
  local right_len=${#right_plain}

  # Calculate spacing
  local spacing=$((COLUMNS - left_len - right_len))

  if [[ $spacing -gt 0 && -n $right_plain ]]; then
    echo "${left}${(l:${spacing}:: :)}${right}"
  else
    echo "${left}"
  fi
}

# Hook function to display divider after command execution
function galpolak_precmd() {
  # Draw a cyan horizontal line
  print -P "%{$fg[cyan]%}${(l:$COLUMNS::┄:)}%{$reset_color%}"
}

# Hook function to add spacing after command input
function galpolak_preexec() {
  # Add a blank line after command input
  print ""
}

# Add hooks using Oh My Zsh's hook system
autoload -U add-zsh-hook
add-zsh-hook precmd galpolak_precmd
add-zsh-hook preexec galpolak_preexec

# Main prompt - two lines with git info on first line
PROMPT='$(prompt_first_line)
%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}'

# Clear right prompt
RPROMPT=''

# Git prompt settings
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}%1{✎%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
