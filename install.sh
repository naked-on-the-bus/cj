      
#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
INSTALL_DIR="$HOME/.local/share/cj"
BIN_DIR="$HOME/.local/bin"
VENV_DIR="$INSTALL_DIR/venv"
MAIN_SCRIPT="src/main.py"
EXECUTABLE_NAME="cj"
REPO_ROOT=$(pwd) # Assumes script is run from the cloned repo root

# --- Helper Functions ---
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

echo_info() {
    echo "[INFO] $1"
}

echo_warn() {
    echo "[WARN] $1"
}

echo_error() {
    echo "[ERROR] $1" >&2
    exit 1
}

# --- Pre-flight Checks ---
echo_info "Checking prerequisites..."

if ! command_exists python3; then
    echo_error "Python 3 is required but not found. Please install Python 3."
fi

if ! command_exists pip; then
    # Sometimes pip is installed as pip3
    if command_exists pip3; then
        PIP_CMD="pip3"
    else
        echo_error "pip (or pip3) is required but not found. Please install pip for Python 3."
    fi
else
    PIP_CMD="pip"
fi
echo_info "Using '$PIP_CMD' for Python packages."

if [ ! -f "$MAIN_SCRIPT" ]; then
    echo_error "Main script '$MAIN_SCRIPT' not found. Make sure you are running this script from the root of the cloned 'cj' repository."
fi

if [ ! -f "requirements.txt" ]; then
    echo_error "'requirements.txt' not found. Make sure you are running this script from the root of the cloned 'cj' repository."
fi

# --- Installation ---
echo_info "Creating installation directory: $INSTALL_DIR"
mkdir -p "$INSTALL_DIR"

echo_info "Creating virtual environment: $VENV_DIR"
python3 -m venv "$VENV_DIR"

echo_info "Installing dependencies from requirements.txt..."
# Activate venv and install - run in a subshell to avoid polluting current shell
(
    source "$VENV_DIR/bin/activate"
    "$PIP_CMD" install --upgrade pip
    "$PIP_CMD" install -r "$REPO_ROOT/requirements.txt"
) || echo_error "Failed to install dependencies."


echo_info "Copying application files..."
# Copy the entire src directory
cp -r "$REPO_ROOT/src" "$INSTALL_DIR/" || echo_error "Failed to copy source files."

# --- Create Executable Wrapper ---
echo_info "Creating executable command: $BIN_DIR/$EXECUTABLE_NAME"
mkdir -p "$BIN_DIR"

# Create the wrapper script that activates the venv and runs main.py
cat << EOF > "$BIN_DIR/$EXECUTABLE_NAME"
#!/bin/bash
# Wrapper script for cj

# Activate virtual environment
source "$VENV_DIR/bin/activate"

# Run the python script
# Note: $INSTALL_DIR already contains the 'src' dir, so path is src/main.py
python "$INSTALL_DIR/src/main.py" "\$@"

# Deactivate is usually not needed as the script exits, but good practice
deactivate
EOF

chmod +x "$BIN_DIR/$EXECUTABLE_NAME" || echo_error "Failed to make command executable."

# --- Post-installation Notes ---
echo_info "Installation complete!"
echo_info "Executable '$EXECUTABLE_NAME' created in '$BIN_DIR'."

# Check if BIN_DIR is in PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo_warn "Directory '$BIN_DIR' is not in your \$PATH."
    echo_warn "You need to add it to your shell configuration file (e.g., ~/.bashrc, ~/.zshrc)."
    echo_warn "Add the following line:"
    echo_warn "  export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo_warn "Then, restart your shell or run 'source ~/.bashrc' (or equivalent)."
else
    echo_info "'$BIN_DIR' is already in your \$PATH. You can now run 'cj' from your terminal."
fi

echo_info "Run 'cj' to start the application and configure it."

    