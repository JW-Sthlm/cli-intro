@echo off
REM ===================================================================
REM cli-intro clean-machine validation launcher
REM Double-click this file to open a fresh Windows Sandbox preloaded
REM with the test kit and prerequisites bootstrap.
REM ===================================================================

where WindowsSandbox.exe >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Windows Sandbox is not installed on this machine.
    echo See enable-sandbox.md for one-time setup instructions.
    echo.
    pause
    exit /b 1
)

start "" "%~dp0sandbox-config.wsb"
exit /b 0
