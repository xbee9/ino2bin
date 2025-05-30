# ino2bin
# 🚀 ino2bin: Arduino Sketch to Binary Compiler

## 📋 Overview

**ino2bin** is a command-line Python tool that automates compiling Arduino `.ino` sketches into `.bin` firmware files, specifically tailored for ESP8266/ESP32 boards. It leverages the official [Arduino CLI](https://arduino.github.io/arduino-cli/latest/) for compilation, ensuring a smooth and reproducible workflow for developers and makers.

---

## 🛠️ Features

- 🔍 **Automatic checks**: Validates sketch and folder structure for Arduino CLI compatibility.
- ⚡ **Fast compilation**: Converts `.ino` files to `.bin` files ready for flashing.
- 📂 **Custom output directory**: Saves compiled binaries in a user-defined or default build folder.
- 🛑 **Clear error messages**: Informs you of missing files, folder mismatches, or compilation failures.

---

## 🖥️ Requirements

- **Python 3.6+**
- **Arduino CLI** (tested with v0.30+)
- **ESP8266/ESP32 board package** installed via Arduino CLI

---

## 📦 Installation

1. **Install Arduino CLI[OPTIONAL INSTALLATION ALREADY INCLUDED IN THE SCRIPT]**  
   Follow the [official instructions](https://arduino.github.io/arduino-cli/latest/installation/) for your OS.

2. **Install ESP8266/ESP32 board support[OPTIONAL INSTALLATION ALREADY INCLUDED IN THE SCRIPT]**  
   Example for ESP8266:
   ```
   arduino-cli core update-index
   arduino-cli core install esp8266:esp8266
   ```

3. **Clone or download this script**  
   ```
   git clone https://github.com/xbee9/ino2bin.git
   cd ino2bin
   chmod +x installer.sh
   ./installer.sh
   ```
4. **Do in a single step**
```
   git clone https://github.com/xbee9/ino2bin.git && cd ino2bin && chmod +x installer.sh && ./installer.sh
```
---

## 🚚 Usage

```bash
python3 ino_to_bin.py path/to/sketch.ino
```

- Make sure your `.ino` file is inside a folder **with the same name** as the sketch.  
  Example:  
  ```
  MyProject/
    MyProject.ino
  ```

- The compiled `.bin` will be saved in the `build/` directory by default.

---

## ⚙️ How It Works

1. Checks if the `.ino` file exists.
2. Verifies that the `.ino` file is in a folder matching its name (Arduino CLI requirement).
3. Compiles the sketch using Arduino CLI.
4. Places the resulting `.bin` file in the `build/` directory.
5. Prints the path to the binary or any error encountered.

---

## 🧰 Example

```bash
python3 ino_to_bin.py Blink/Blink.ino
```
Output:
```
[+] Compiling Blink.ino to .bin...
[+] Success: Binary located at:
    /your/path/build/Blink.ino.bin
```

---
## 📝 Dependencies
- [Arduino CLI](https://arduino.github.io/arduino-cli/latest/)
- Python 3.6 or higher
- ESP8266/ESP32 board packages (install via Arduino CLI)
---
## ❓ Troubleshooting
- **File not found**: Ensure the path to your `.ino` is correct.
- **Folder mismatch**: Move your `.ino` into a folder with the same name.
- **Compilation failed**: Check the error message for missing libraries or syntax errors.
- **.bin not found**: Confirm you are targeting a board that produces a `.bin` (like ESP8266/ESP32).
---
## 🤝 Contributing
Pull requests are welcome! Please open an issue first to discuss major changes.
---
> Happy hacking! 🤖✨
> Made With :)
