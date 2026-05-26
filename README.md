# win.bat

Batch files for Windows personal productivity.

## Files

| File  | Description                                                                               |
| :---- | :---------------------------------------------------------------------------------------- |
| `sym` | Create a symlink in `C:\Windows\` pointing to the script's own directory (requires admin) |
| `vsc` | Open the current directory in Visual Studio Code                                          |

## Registering bat files

To call bat files anywhere via `PATH`, create symlinks under `C:\Windows\`.

### First-time setup

Open PowerShell or cmd **as Administrator**, then run:

```powershell
New-Item -ItemType SymbolicLink -Path "C:\Windows\sym.bat" -Target "<path-to-repo>\bat\sym.bat"
```

### Adding or updating a bat file

```
sym <filename-without-extension>
```

Example — after adding `a.bat`:

```
sym a
```

## Tech Stack

| Tool                                | Purpose             |
| :---------------------------------- | :------------------ |
| [Prettier](https://prettier.io/) v3 | Markdown formatting |

## Formatting

```bash
npm install
npm run format
```
