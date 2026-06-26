#!/usr/bin/env bash

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}===================================================${NC}"
echo -e "${BLUE}             FluxMedia Bootstrapper                ${NC}"
echo -e "${BLUE}===================================================${NC}"
echo

# Detect environment
if [ -n "$TERMUX_VERSION" ]; then
    echo -e "${GREEN}[INFO] Environment: Termux (Android)${NC}"
else
    echo -e "${GREEN}[INFO] Environment: Linux/macOS${NC}"
fi
echo

# Get directory where script resides
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# 1. Detect if python3 is installed
if ! command -v python3 &> /dev/null; then
    # Fallback to python
    if command -v python &> /dev/null; then
        PYTHON_CMD="python"
    else
        echo -e "${RED}[ERROR] Python 3 is not installed.${NC}"
        echo "Please install Python 3.10+ using your package manager."
        echo "Example (Ubuntu/Debian): sudo apt update && sudo apt install python3 python3-pip python3-venv"
        echo "Example (macOS via Homebrew): brew install python"
        echo "Example (Termux): pkg install python"
        exit 1
    fi
else
    PYTHON_CMD="python3"
fi

# 2. Check Python version (need 3.10+)
PYTHON_VERSION=$($PYTHON_CMD -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')
MAJOR=$(echo "$PYTHON_VERSION" | cut -d. -f1)
MINOR=$(echo "$PYTHON_VERSION" | cut -d. -f2)

if [ "$MAJOR" -lt 3 ] || { [ "$MAJOR" -eq 3 ] && [ "$MINOR" -lt 10 ]; }; then
    echo -e "${YELLOW}[WARNING] FluxMedia requires Python 3.10+. Current version: $PYTHON_VERSION${NC}"
    echo "Some features might not work properly."
fi

# 3. Detect if python-venv is available
if ! $PYTHON_CMD -c "import venv" &> /dev/null; then
    echo -e "${RED}[ERROR] The Python 'venv' module is missing.${NC}"
    echo "Please install python3-venv."
    echo "Example (Ubuntu/Debian): sudo apt install python3-venv"
    echo "Example (Termux): It should be included, check Python install."
    exit 1
fi

# 4. Create virtual environment if it does not exist
if [ ! -d "$SCRIPT_DIR/.venv" ]; then
    echo -e "${BLUE}[INFO] Creating Python virtual environment in .venv...${NC}"
    $PYTHON_CMD -m venv "$SCRIPT_DIR/.venv"
    if [ $? -ne 0 ]; then
        echo -e "${RED}[ERROR] Failed to create virtual environment.${NC}"
        exit 1
    fi
    echo -e "${GREEN}[INFO] Virtual environment created successfully.${NC}"
fi

# 5. Activate virtual environment
echo -e "${BLUE}[INFO] Activating virtual environment...${NC}"
if [ -f "$SCRIPT_DIR/.venv/bin/activate" ]; then
    source "$SCRIPT_DIR/.venv/bin/activate"
else
    echo -e "${RED}[ERROR] Activation script not found in .venv/bin/activate.${NC}"
    exit 1
fi

# 6. Upgrade pip and install package
echo -e "${BLUE}[INFO] Upgrading pip...${NC}"
python -m pip install --upgrade pip > /dev/null 2>&1

echo -e "${BLUE}[INFO] Installing FluxMedia package and dependencies...${NC}"
python -m pip install -e "$SCRIPT_DIR/." > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "${RED}[ERROR] Failed to install package.${NC}"
    exit 1
fi

# 7. Launch Python application
echo -e "${GREEN}[INFO] Starting FluxMedia...${NC}"
python "$SCRIPT_DIR/fluxmedia_aio.py"
EXIT_CODE=$?

# Keep exit code
exit $EXIT_CODE
