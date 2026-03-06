#!/bin/bash
set -e

APP_NAME="ShiftRepeater"
APP_DIR="dist/${APP_NAME}.app"
CONTENTS="${APP_DIR}/Contents"
MACOS="${CONTENTS}/MacOS"
RESOURCES="${CONTENTS}/Resources"

# Clean
rm -rf dist

# Build release
swift build -c release

# Create .app bundle structure
mkdir -p "${MACOS}"
mkdir -p "${RESOURCES}"

# Copy binary
cp ".build/release/${APP_NAME}" "${MACOS}/${APP_NAME}"

# Info.plist
cat > "${CONTENTS}/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleName</key>
    <string>ShiftRepeater</string>
    <key>CFBundleDisplayName</key>
    <string>Shift Repeater</string>
    <key>CFBundleIdentifier</key>
    <string>com.local.shiftrepeater</string>
    <key>CFBundleVersion</key>
    <string>1.0.0</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0.0</string>
    <key>CFBundleExecutable</key>
    <string>ShiftRepeater</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>LSMinimumSystemVersion</key>
    <string>13.0</string>
    <key>LSUIElement</key>
    <true/>
    <key>NSHighResolutionCapable</key>
    <true/>
    <key>CFBundleIconFile</key>
    <string>AppIcon</string>
</dict>
</plist>
EOF

echo "✅ ${APP_DIR} creato!"

# Generate icon
swift generate-icon.swift
rm -f /tmp/ShiftRepeater.iconset/icon_64x64.png /tmp/ShiftRepeater.iconset/icon_64x64@2x.png
iconutil -c icns /tmp/ShiftRepeater.iconset -o "${RESOURCES}/AppIcon.icns"

echo ""
echo "Per installare:"
echo "  cp -r dist/${APP_NAME}.app /Applications/"
echo ""
echo "Ricorda di abilitare Accessibilità in:"
echo "  Impostazioni → Privacy e Sicurezza → Accessibilità"
