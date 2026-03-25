@echo off
REM Cross-platform batch file to update .copilot agents and skills
setlocal enabledelayedexpansion

echo 🤖 Copilot Agents ^& Skills Updater (Windows)
echo ==========================================

REM Set .copilot location
set COPILOT_DIR=%USERPROFILE%\.copilot
echo [INFO] Copilot location: %COPILOT_DIR%

REM Create directories
echo [INFO] Creating directories...
if not exist "%COPILOT_DIR%\agents" mkdir "%COPILOT_DIR%\agents"
if not exist "%COPILOT_DIR%\skills" mkdir "%COPILOT_DIR%\skills"

REM Update repository
echo [INFO] Updating repository...
git pull >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Failed to update repository
    pause
    exit /b 1
)

REM Copy agents
echo [INFO] Copying agents...
for %%f in (*.agent.md) do (
    copy "%%f" "%COPILOT_DIR%\agents\" >nul 2>&1
    echo   → %%f
)

REM Copy skills
echo [INFO] Copying skills...
if exist "skills" (
    xcopy "skills" "%COPILOT_DIR%\skills" /E /Y /Q >nul 2>&1
)

REM Copy notes
echo [INFO] Copying notes...
if exist "notes" (
    xcopy "notes" "%COPILOT_DIR%\notes" /E /Y /Q >nul 2>&1
)

echo.
echo [SUCCESS] ✅ Copilot agents and skills updated!
echo [INFO] You may need to restart VS Code for changes to take effect.
echo.
pause