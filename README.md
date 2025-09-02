## Commands & Skripte – Sammlung

Diese Sammlung enthält nützliche Befehle und Skripte. Beiträge willkommen.

---

### Alle ComfyUI Custom-Nodes auf SSH-URL umstellen & aktualisieren

Diese Anleitung stellt alle bereits per HTTPS geklonten Custom-Nodes auf SSH um und aktualisiert sie anschließend.

#### Voraussetzungen
- **WSL** (Linux-Umgebung unter Windows) ist eingerichtet
- **Git** ist installiert und über `git` verfügbar
- SSH-Key ist eingerichtet und bei GitHub hinterlegt

#### 1) SSH-Remote in einem Rutsch setzen (in WSL ausführen)
Kopiere und führe diesen Einzeiler im Verzeichnis `~/ComfyUI/custom_nodes` aus:

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

#### 2) Updates ausführen

**Variante A – ComfyUI-Manager**
- ComfyUI-Manager öffnen → „Update all“ klicken

**Variante B – Terminal**

```bash
cd ~/ComfyUI/custom_nodes
for d in */; do (cd "$d" && git pull); done
```

Fertig – alle Nodes sind nun per SSH konfiguriert und auf dem neuesten Stand.


