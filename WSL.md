## WSL – Befehle & Skripte

Diese Datei bündelt alle WSL-bezogenen Anleitungen und Skripte.

---

### ComfyUI: Custom-Nodes auf SSH-URL umstellen

Stellt alle bereits per HTTPS geklonten Custom-Nodes in `~/ComfyUI/custom_nodes` auf SSH um.

Voraussetzungen:
- Git ist installiert und über `git` verfügbar
- SSH-Key ist eingerichtet und bei GitHub hinterlegt

Einzeiler:

```bash
cd ~/ComfyUI/custom_nodes
for d in */; do
  [[ -d "$d/.git" ]] || continue
  remote=$(git -C "$d" config --get remote.origin.url)
  [[ $remote == https://github.com/* ]] || continue
  new_url=${remote/https:\/\/github.com\//git@github.com:}
  echo "Umschreiben $d  $remote  ->  $new_url"
  git -C "$d" remote set-url origin "$new_url"
done
```

Windows (.bat) Alternative:
- `convert-comfyui-remotes-to-ssh.bat` (ruft intern WSL auf)

---

### ComfyUI: Custom-Nodes aktualisieren

Variante A – ComfyUI-Manager:
- ComfyUI-Manager öffnen → „Update all“

Variante B – Terminal:

```bash
cd ~/ComfyUI/custom_nodes
for d in */; do (cd "$d" && git pull); done
```

Windows (.bat) Alternative:
- `update-comfyui-custom-nodes.bat` (ruft intern WSL auf)

---

### ComfyUI: Starten auf Port 8188

Direkt in WSL:

```bash
cd ~/ComfyUI && source venv/bin/activate && python main.py --listen --port 8188
```

Windows (.bat) Alternative:
- `start-comfyui-8188.bat` (ruft intern WSL auf)


