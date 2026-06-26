@echo off
setlocal enabledelayedexpansion

echo ===================================================
echo             FluxMedia Bootstrapper
echo ===================================================
echo.

:: 1. Detect if Python is installed
set "PYTHON_CMD=python"
python --version >nul 2>&1
if errorlevel 1 (
    py --version >nul 2>&1
    if errorlevel 1 (
        echo [ERROR] Python is not installed or not in your PATH.
        echo Please install Python 3.10 or higher from: https://www.python.org/
        echo Make sure to check the box "Add Python to PATH" during installation.
        echo.
        pause
        exit /b 1
    ) else (
        set "PYTHON_CMD=py -3"
        echo [INFO] Detected Python Launcher. Using "py -3".
    )
)

:: 2. Create virtual environment if it does not exist
if not exist "%~dp0.venv" (
    echo [INFO] Creating Python virtual environment in .venv...
    !PYTHON_CMD! -m venv "%~dp0.venv"
    if errorlevel 1 (
        echo [ERROR] Failed to create virtual environment.
        pause
        exit /b 1
    )
    echo [INFO] Virtual environment created successfully.
)

:: 3. Activate virtual environment
echo [INFO] Activating virtual environment...
call "%~dp0.venv\Scripts\activate.bat"
if errorlevel 1 (
    echo [ERROR] Failed to activate virtual environment.
    pause
    exit /b 1
)

:: 4. Upgrade pip and install package
echo [INFO] Upgrading pip...
python -m pip install --upgrade pip >nul 2>&1

echo [INFO] Installing FluxMedia package and dependencies...
python -m pip install -e "%~dp0." >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Failed to install package.
    pause
    exit /b 1
)

:: 5. Launch application
echo [INFO] Starting FluxMedia...
python "%~dp0fluxmedia_aio.py"
set EXIT_CODE=%ERRORLEVEL%

if %EXIT_CODE% neq 0 (
    echo.
    echo [INFO] FluxMedia exited with an error.
    pause
)

endlocal
exit /b %EXIT_CODE%
