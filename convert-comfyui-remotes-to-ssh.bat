@echo off
setlocal

where wsl >nul 2>&1
if errorlevel 1 (
  echo [Fehler] WSL wurde nicht gefunden. Bitte installiere WSL und versuche es erneut.
  exit /b 1
)

echo [Info] Stelle alle ComfyUI Custom-Nodes von HTTPS auf SSH um ...
wsl -e bash -lc 'cd ~/ComfyUI/custom_nodes && for d in */; do [[ -d "$d/.git" ]] || continue; remote=$(git -C "$d" config --get remote.origin.url); [[ $remote == https://github.com/* ]] || continue; new_url=${remote/https:\/\/github.com\//git@github.com:}; echo "Umschreiben $d  $remote  ->  $new_url"; git -C "$d" remote set-url origin "$new_url"; done'
if errorlevel 1 (
  echo [Fehler] Ausfuehrung in WSL fehlgeschlagen.
  exit /b 1
)

echo [Fertig] Alle passenden Repositories wurden auf SSH umgestellt.
endlocal


