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

# Function to calculate the visible length of a prompt string
function prompt-length() {
  emulate -L zsh
  local COLUMNS=${2:-$COLUMNS}
  local -i x y=$#1 m
  if (( y )); then
    while (( ${${(%):-$1%$y(l.1.0)}[-1]} )); do
      x=y
      (( y *= 2 ));
    done
    local xy
    while (( y > x + 1 )); do
      m=$(( x + (y - x) / 2 ))
      typeset ${${(%):-$1%$m(l.x.y)}[-1]}=$m
    done
  fi
  echo $x
}

# Function to create a line with content on left and right
function fill-line() {
  emulate -L zsh
  local left_len=$(prompt-length $1)
  local right_len=$(prompt-length $2 9999)
  local pad_len=$((COLUMNS - left_len - right_len - ${ZLE_RPROMPT_INDENT:-1}))
  if (( pad_len < 1 )); then
    echo -E - ${1}
  else
    local pad=${(pl.$pad_len.. .)}
    echo -E - ${1}${pad}${2}
  fi
}

# Function to render the first line with git on the right
function prompt_first_line() {
  local left="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )%{$reset_color%}%{$fg[cyan]%}%c%{$reset_color%}"
  local right="$(_omz_git_prompt_info)$(git_modified_files_count)"

  fill-line "$left" "$right"
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

# Handle terminal resize to prevent prompt duplication
TRAPWINCH() {
  if [[ -o zle ]]; then
    # Clear current prompt line before redrawing
    print -n '\r\e[K'
    zle .reset-prompt
  fi
}

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
