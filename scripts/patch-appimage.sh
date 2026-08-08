#!/bin/bash
set -e

APPIMAGE=$(find out/make -name "*.AppImage" | head -1)
echo "Patching: $APPIMAGE"

# Extract
"$APPIMAGE" --appimage-extract

# Replace icon
cp src/assets/icons/ytmd.png squashfs-root/usr/share/icons/hicolor/256x256/apps/youtube-music-desktop-app.png
cp src/assets/icons/ytmd.png squashfs-root/.DirIcon

# Repack
wget -q https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage -O appimagetool
chmod +x appimagetool
ARCH=x86_64 ./appimagetool squashfs-root "$APPIMAGE"

# Cleanup
rm -rf squashfs-root appimagetool
echo "Done: $APPIMAGE"