```bash
   ##################        ############# 
 ######################     ###############
####                ####    ####       ####
####                 ###    ####       ####
####                 ###    ####       ####
####       ##        ###    ####       ####
####       ##        ###########       ####
####       #####################       ####
####       ##        #        ##       ####
####       ##        #        ##       ####
####       ##        #        ##       ####
####                 #                 ####
####                 #                 ####
####                ###                ####
 ######################################### 
   ################## ##################   
```

`cj` stands for [Carl Jonson](https://it.wikipedia.org/wiki/Carl_Johnson_(Grand_Theft_Auto)).

This is interactive command-line interface (CLI) tool to chat with Google's Generative AI models (like Gemini) directly from your Linux terminal.

It maintains a conversation history within a session and logs the entire chat to a Markdown file. Responses are displayed using `glow` if available.

## Features

*   Interactive chat session in the terminal.
*   Uses Google's Gemini models via the `google-generativeai` library.
*   Configurable API key and AI model selection via interactive menus.
*   Uses `glow` for pretty Markdown rendering in the terminal (optional).
*   User-friendly installation script.

## Requirements

To set up the project, you will need the following installed on your system:

* **Linux Operating System**
* **Python 3** (tested with 3.8+, likely works with 3.7+)
* **pip** (Python package installer, usually comes with Python 3)
* **git** (for cloning the repository)
* **glow** (Optional, for better Markdown display)

Here are the commands to install these requirements on common Linux distributions:

**Debian/Ubuntu:**

You can install the requirements using `apt`:

```bash
sudo apt update
sudo apt install python3 python3-pip python3.12-venv git
// add the charm repo
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg
echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list
sudo apt update && sudo apt install glow
```

**For Arch Linux:**

You can install the requirements using `pacman`:

```bash
sudo pacman -S python python-pip git glow
```

**Manual Glow Installation (if not available via package manager):**

If `glow` is not available in your distribution's repositories, you can download a binary release from the [Glow Releases page](https://github.com/charmbracelet/glow/releases) and place it in your system's PATH (e.g., `/usr/local/bin`).

## Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/naked-on-the-bus/cj.git
    cd cj
    ```

2.  **Run the installer script:**
    ```bash
    chmod +x install.sh
    ./install.sh
    ```

3.  **Ensure `~/.local/bin` is in your PATH:**
    Some Python tools install executables into `~/.local/bin`. For these to be runnable directly from your terminal, this directory needs to be in your PATH.

    Display your current PATH with:

    ```bash
    echo $PATH
    ```

    Please examine the output to confirm if `~/.local/bin` is present in the colon-separated list of directories.

    If `~/.local/bin` is **not** in your PATH, add the following line to your shell configuration file (e.g., `~/.bashrc`, `~/.zshrc`, `~/.profile`):

    ```bash
    export PATH="$HOME/.local/bin:$PATH"
    ```

    After thar open a new terminal. and you good to go.

## Configuration

The first time you run `cj` after installation, it will guide you through setting up:

1.  Run `cj` in your terminal:
    ```bash
    cj
    ```

2.  Select 'start conversation' to begin chatting.

Your settings will be saved in `~/.config/cj/cj.json`.

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
