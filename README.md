## Commands & Skripts – Sammlung

Diese Repository wird eine wachsende Sammlung nützlicher Befehle und Skripte.

### Rezept: Alle Custom-Nodes auf SSH-URL umstellen & aktualisieren

#### Voraussetzungen
- **WSL und Git**: Unter Windows in WSL ausführen
- **SSH-Schlüssel**: Bereits bei GitHub hinterlegt (empfohlen: Ed25519)
  - Schlüssel erstellen und dem Agenten hinzufügen:
    ```bash
    ssh-keygen -t ed25519 -C "dein_github_email"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519
    ```
  - Public Key anzeigen und bei GitHub unter „SSH and GPG keys“ hinzufügen:
    ```bash
    cat ~/.ssh/id_ed25519.pub
    ```
    GitHub-Link: [SSH Keys verwalten](https://github.com/settings/keys)
- **Pfad vorhanden**: `~/ComfyUI/custom_nodes`

#### 1) SSH-Remote in einem Rutsch setzen
Kopiere & führe dieses Einzeiler-Skript in WSL aus:

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

Optional: Remotes prüfen (ersetze `SOME_NODE_DIR` mit einem konkreten Verzeichnis):
```bash
git -C SOME_NODE_DIR remote -v
```

#### 2) Updates ausführen

- **Variante A – ComfyUI-Manager**: ComfyUI-Manager → „Update all“ öffnen
- **Variante B – Terminal**:
  ```bash
  cd ~/ComfyUI/custom_nodes
  for d in */; do (cd "$d" && git pull); done
  ```

#### Ergebnis
Alle Nodes sind jetzt per SSH angebunden und auf dem neuesten Stand.

#### Troubleshooting
- **Permission denied (publickey)**
  - SSH-Verbindung testen:
    ```bash
    ssh -T git@github.com
    ```
  - Geladene Schlüssel anzeigen:
    ```bash
    ssh-add -l
    ```
  - Falls kein Key geladen ist, erneut hinzufügen:
    ```bash
    ssh-add ~/.ssh/id_ed25519
    ```

Weitere Rezepte und Skripte folgen sukzessive.
