@echo off
setlocal

where wsl >nul 2>&1
if errorlevel 1 (
  echo [Fehler] WSL wurde nicht gefunden. Bitte installiere WSL und versuche es erneut.
  exit /b 1
)

echo [Info] Starte ComfyUI auf Port 8188 (WSL)...
wsl -e bash -lc 'cd ~/ComfyUI && source venv/bin/activate && python main.py --listen --port 8188'
if errorlevel 1 (
  echo [Fehler] ComfyUI konnte nicht gestartet werden.
  exit /b 1
)

endlocal


