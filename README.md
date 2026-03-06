# Shift Repeater ⇧

A minimal macOS menu bar app that repeatedly sends Shift key presses to the active application.

## Features

- Lives in the menu bar — zero screen clutter
- Click to toggle Shift key repetition on/off
- Icon changes state: outlined (off) / filled (active)
- Keyboard shortcuts: `⌘S` toggle, `⌘Q` quit
- 1 second interval between presses

## Requirements

- macOS 13.0+
- Accessibility permission (System Settings → Privacy & Security → Accessibility)

## Build & Install

```bash
# Build the .app bundle
bash build-app.sh

# Copy to Applications
cp -r dist/ShiftRepeater.app /Applications/
```

Or run directly during development:

```bash
swift run
```

## Permissions

On first launch, macOS will require you to grant Accessibility access. Go to:

**System Settings → Privacy & Security → Accessibility** → enable ShiftRepeater.

Without this permission, key events won't be delivered to other applications.

## License

MIT
