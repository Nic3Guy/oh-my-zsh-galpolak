# Custom Oh My Zsh Theme - Galpolak

A custom Oh My Zsh theme based on robbyrussell with enhanced git information and multi-line prompt.

## Features

- **Multi-line prompt**: Command input on a separate line for better readability
- **Git branch on the right**: Branch name aligned to the right side of the terminal
- **Modified files count**: Shows the number of modified files in yellow brackets `[3]`
- **Visual indicators**:
  - Green arrow `➜` when last command succeeds
  - Red arrow `➜` when last command fails
  - Yellow pencil `✎` when git repository has uncommitted changes
  - Current directory in cyan

## Preview

```
➜  riverpool                                        git:(branch-name)[3] ✎

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

## License

Free to use and modify.
