# Custom Oh My Zsh Theme - Galpolak

A custom Oh My Zsh theme based on robbyrussell with enhanced git information, multi-line prompt, and elegant visual separators.

## Features

- **Multi-line prompt with dual arrows**: 
  - First line shows directory and git info
  - Second line shows arrow for command input
  - Both arrows share the same color based on last command status (green for success, red for failure)
- **Git branch on the right**: Branch name aligned to the right side of the terminal
- **Modified files count**: Shows the number of modified files in yellow brackets `[3]`
- **Visual separators**: Clean dividers between prompts and command outputs
  - Cyan dividers before prompts
  - Grey dividers before command outputs
  - Uses technical line character (⎯) for a modern look
- **Visual indicators**:
  - Green arrows `➜` when last command succeeds
  - Red arrows `➜` when last command fails (both lines turn red)
  - Yellow pencil `✎` when git repository has uncommitted changes
  - Current directory in cyan

## Preview

```
⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯
➜  riverpool                                        git:(branch-name)[3] ✎
➜ ls
⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯
file1.txt    file2.txt    directory/
⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯⎯
➜  riverpool                                        git:(branch-name)[3] ✎
➜ 
```

## Installation

1. Download the theme file:
   ```bash
   curl -o ~/.oh-my-zsh/custom/themes/galpolak.zsh-theme https://raw.githubusercontent.com/Nic3Guy/oh-my-zsh-galpolak/main/galpolak.zsh-theme
   ```

2. Edit your `~/.zshrc` file and set the theme:
   ```bash
   ZSH_THEME="galpolak"
   ```

3. Reload your terminal or run:
   ```bash
   source ~/.zshrc
   ```

## Customization

You can modify the theme file to customize:

- **Colors**: Change `$fg[color]` or `$fg_bold[color]` (available: black, red, green, yellow, blue, magenta, cyan, white, grey)
- **Dirty indicator**: Change the `✎` symbol to something else (e.g., `✗`, `●`, `✱`, `*`)
- **Directory display**: Change `%c` to `%~` to show full path instead of just current directory
- **Divider character**: Change `⎯` to other line styles like `─`, `━`, `═`, `┄`, or `-`
- **Divider colors**: Modify the colors in `precmd()` and `preexec()` functions

## Technical Details

- Uses `_omz_git_prompt_info` for synchronous git information display
- Implements `precmd` hook for dividers before prompts
- Implements `preexec` hook for dividers before command outputs
- Captures exit status early to ensure both arrows have matching colors
- Dynamically calculates spacing to align git info to the right
- Automatically adjusts to terminal width

## License

Free to use and modify.
