🐧 PortfoLinux

PortfoLinux is a browser-native project that embeds a full Linux operating system entirely client-side using [v86], a WebAssembly-based x86 emulator. When the page loads, the browser initializes the v86 engine, loads a BIOS, Linux kernel, and root filesystem image directly into memory, and boots into a live Linux shell — all without any server-side code.

The process emulates a full virtual machine environment inside the browser sandbox, with memory, CPU, and file I/O handled by the emulator. A terminal interface is wired to v86’s virtual serial output, allowing users to interact with the live Linux system in real time through a browser-based terminal.

No container engines. No WebAssembly tricks. Just raw Linux bootstrapped inside a browser tab.
