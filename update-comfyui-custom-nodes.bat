@echo off
setlocal

where wsl >nul 2>&1
if errorlevel 1 (
  echo [Fehler] WSL wurde nicht gefunden. Bitte installiere WSL und versuche es erneut.
  exit /b 1
)

echo [Info] Aktualisiere alle ComfyUI Custom-Nodes ...
wsl -e bash -lc 'cd ~/ComfyUI/custom_nodes && for d in */; do (cd "$d" && git pull); done'
if errorlevel 1 (
  echo [Fehler] Ausfuehrung in WSL fehlgeschlagen.
  exit /b 1
)

echo [Fertig] Alle Repositories wurden aktualisiert.
endlocal


