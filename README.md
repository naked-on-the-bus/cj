# CJ - Command Line AI Assistant

CJ stands for [Carl Jonson](https://it.wikipedia.org/wiki/Carl_Johnson_(Grand_Theft_Auto)).

This is interactive command-line interface (CLI) tool to chat with Google's Generative AI models (like Gemini) directly from your Linux terminal.

It maintains a conversation history within a session and logs the entire chat to a Markdown file. Responses are displayed using `glow` if available, otherwise printed directly.

## Features

*   Interactive chat session in the terminal.
*   Uses Google's Gemini models via the `google-generativeai` library.
*   Configurable API key and AI model selection via interactive menus.
*   Saves configuration to `~/.config/cj/cj.ini`.
*   Logs conversation history to `/var/tmp/cj/conversation_log.md`.
*   Uses `glow` for pretty Markdown rendering in the terminal (optional).
*   User-friendly installation script.

## Requirements

*   **Linux Operating System**
*   **Python 3** (tested with 3.8+, likely works with 3.7+)
*   **pip** (Python package installer, usually comes with Python 3)
*   **git** (for cloning the repository)
*   **glow** (Optional, for better Markdown display): Install via your package manager (e.g., `sudo apt install glow`, `sudo dnf install glow`) or from [Glow Releases](https://github.com/charmbracelet/glow/releases).

## Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/cj.git # Replace with your actual repo URL
    cd cj
    ```

2.  **Run the installer script:**
    ```bash
    ./install.sh
    ```

3.  **Ensure `~/.local/bin` is in your PATH:**
    The installer script will check this. If it's not in your PATH, add the following line to your shell configuration file (e.g., `~/.bashrc`, `~/.zshrc`):
    ```bash
    export PATH="$HOME/.local/bin:$PATH"
    ```
    Then, either restart your terminal or run `source ~/.bashrc` (or the equivalent for your shell).

## Configuration

The first time you run `cj` after installation, it will guide you through setting up:

1.  Run `cj` in your terminal:
    ```bash
    cj
    ```
2.  Use the menu to select 'set google api key' and enter your API key obtained from [Google AI Studio](https://aistudio.google.com/app/apikey).
3.  Use the menu to select 'set ai model' and choose one of the available Gemini models.
4.  Select 'start conversation' to begin chatting.

Your settings will be saved in `~/.config/cj/cj.ini`.

## Uninstallation

To remove `cj` and its configuration:

```bash
# Remove the installed application files
rm -rf "$HOME/.local/share/cj"

# Remove the executable link
rm -f "$HOME/.local/bin/cj"

# Remove the configuration directory (optional, keeps your API key if you might reinstall)
rm -rf "$HOME/.config/cj"

# Remove the log directory (optional)
rm -rf "/var/tmp/cj"

echo "cj has been uninstalled."