# TriPlayer Filename Sanitizer

Cleans up filenames for [TriPlayer](https://github.com/yourlink) on Nintendo Switch.

- Converts accented characters to plain ASCII (e.g., `café` → `cafe`)
- Replaces any remaining non‑alphanumeric characters (except `._ -`) with underscores
- Renames both **files and folders** recursively in the correct order
- Prevents conflicts by adding numeric suffixes (`_1`, `_2`, …) if a name already exists

## Usage
1. Place `triplayer-sanitize.sh` in the root of your music collection.
2. Run a **dry‑run** to preview changes:
   ```bash
   DRY_RUN=1 ./triplayer-sanitize.sh