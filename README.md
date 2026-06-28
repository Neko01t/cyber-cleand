# cyber-cleand

## About the Project

`cyber-cleand` is a local, event-driven system daemon designed to automatically organize and route files across a local filesystem in real-time. It operates entirely in the background, intercepting file creation and movement events to maintain structured directories without manual intervention.

## Objective

The primary goal of this project is to build a highly efficient, zero-polling background utility that keeps high-traffic directories (like Downloads and Documents) clutter-free. By utilizing OS-level file system events (rather than resource-heavy periodic scanning), it ensures minimal CPU and battery consumption.

Additionally, this repository serves as an exercise in iterative systems engineering:

1. **Phase 1 (MVP):** Implementation via Shell Scripting utilizing kernel-level watcher utilities.
2. **Phase 2 (Cross-Platform):** Implementation via Rust for native cross-platform compatibility and performance optimization.

---

## How to Run

```bash
git clone https://github.com/Neko01t/cyber-cleand
cd cyber-cleand && mkdir rust
cd bash
pacman -S inotify-tools
chmod +x ./cyber-cleand scanner.sh
./scanner.sh
```

For now **Test Mode** is default
If you want changes to be permanent and not revert by debug ,use

```bash
./cyber-cleand prod
```

## License

This project is licensed under the MIT License.

Copyright (c) 2026

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
