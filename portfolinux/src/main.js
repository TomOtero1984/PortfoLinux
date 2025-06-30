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
