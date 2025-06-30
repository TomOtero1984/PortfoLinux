#!/bin/bash

set -e
echo "🛠  Setting up PortfoLinux..."

mkdir -p portfolinux/{public/v86,public/xterm,src}

# v86 core files
echo "📦 Downloading v86..."
curl -L https://copy.sh/v86/build/v86.js -o portfolinux/public/v86/v86.js
curl -L https://copy.sh/v86/build/v86.wasm -o portfolinux/public/v86/v86.wasm
curl -L https://copy.sh/v86/seabios/seabios.bin -o portfolinux/public/v86/seabios.bin
curl -L https://copy.sh/v86/seabios/vgabios.bin -o portfolinux/public/v86/vgabios.bin
curl -L https://copy.sh/v86/images/linuxkernel -o portfolinux/public/v86/linuxkernel
curl -L https://copy.sh/v86/images/rootfs.ext2 -o portfolinux/public/v86/rootfs.ext2

# xterm.js (latest from jsDelivr)
echo "🖥  Downloading xterm.js..."
curl -L https://cdn.jsdelivr.net/npm/xterm@5.3.0/lib/xterm.min.js -o portfolinux/public/xterm/xterm.js
curl -L https://cdn.jsdelivr.net/npm/xterm@5.3.0/css/xterm.css -o portfolinux/public/xterm/xterm.css

# index.html
cat <<EOF > portfolinux/index.html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>PortfoLinux</title>
    <link rel="stylesheet" href="/xterm/xterm.css" />
    <style>
      body { background: black; margin: 0; height: 100vh; }
      #terminal { width: 100%; height: 100vh; }
    </style>
  </head>
  <body>
    <div id="terminal"></div>
    <script type="module" src="/src/main.js"></script>
  </body>
</html>
EOF

# main.js
cat <<EOF > portfolinux/src/main.js
import { Terminal } from "/xterm/xterm.js";
import "/xterm/xterm.css";

const term = new Terminal({ cols: 80, rows: 24 });
term.open(document.getElementById("terminal"));

const emulator = new window.V86Starter({
  wasm_path: "/v86/v86.wasm",
  memory_size: 128 * 1024 * 1024,
  vga_memory_size: 2 * 1024 * 1024,
  screen_container: null,
  serial_container: term.element,
  bios: { url: "/v86/seabios.bin" },
  vga_bios: { url: "/v86/vgabios.bin" },
  kernel: { url: "/v86/linuxkernel" },
  filesystem: { url: "/v86/rootfs.ext2" },
  autostart: true,
});
EOF

echo "✅ PortfoLinux is ready."
echo "👉 cd portfolinux && npm create vite@latest && npm run dev"
