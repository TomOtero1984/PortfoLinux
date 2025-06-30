import V86 from "/src/libv86.js";
import { Terminal } from "xterm";
import "/styles/xterm.css";

const term = new Terminal({ cols: 80, rows: 24 });
term.open(document.getElementById("terminal"));

window.onload = function () {
    var emulator = new V86({
        wasm_path: "/src/v86.wasm",
        memory_size: 512 * 1024 * 1024,
        vga_memory_size: 8 * 1024 * 1024,
        screen_container:
            document.getElementById("screen_container"),
        bios: { url: "/v86/bios/seabios.bin" },
        vga_bios: { url: "/v86/bios/vgabios.bin" },
        filesystem: {
            baseurl: "/images/linux/",
            basefs: "/images/linux/fs.json",
        },
        autostart: true,
        cmdline: "rw root=host9p rootfstype=9p rootflags=trans=virtio,cache=loose modules=virtio_pci tsc=reliable",

    });
};
