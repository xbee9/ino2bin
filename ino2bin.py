import subprocess
import os
import sys
#in2bin main fn.
def compile_ino_to_bin(ino_path, board_fqbn="esp8266:esp8266:nodemcuv2", build_path="build"):
    if not os.path.isfile(ino_path):
        print(f"[!] File not found: {ino_path}")
        sys.exit(1)

    sketch_name = os.path.splitext(os.path.basename(ino_path))[0]
    sketch_dir = os.path.dirname(os.path.abspath(ino_path))
#Check if the .ino file is inside a folder that matches its name
    if os.path.basename(sketch_dir) != sketch_name:
        print(f"[!] Arduino CLI requires the .ino file to be in a folder named '{sketch_name}/'")
        print(f"[!] Move '{ino_path}' into a folder named '{sketch_name}/' and try again.")
        sys.exit(1)

    build_dir = os.path.abspath(build_path)
    os.makedirs(build_dir, exist_ok=True)

    print(f"[+] Compiling {sketch_name}.ino to .bin...")

    compile_cmd = [
        "arduino-cli", "compile",
        "--fqbn", board_fqbn,
        "--output-dir", build_dir,
        "--warnings", "none",
        sketch_dir
    ]

    result = subprocess.run(compile_cmd, capture_output=True, text=True)

    if result.returncode != 0:
        print("[!] Compilation failed:\n", result.stderr)
        sys.exit(2)

    bin_file = os.path.join(build_dir, f"{sketch_name}.ino.bin")
    if os.path.isfile(bin_file):
        print(f"[+] Success: Binary located at:\n    {bin_file}")
        return bin_file
    else:
        print("[!] Compilation succeeded but .bin not found.")
        sys.exit(3)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 ino_to_bin.py path/to/sketch.ino")
        sys.exit(1)

    ino_path = sys.argv[1]
    compile_ino_to_bin(ino_path)
                                            
