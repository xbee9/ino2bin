#!/bin/bash
set -e
echo "🚀 Installing dependencies for ino2bin......."

#python 3
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed. Please install Python 3 and rerun this script."
    exit 1
fi

#pip3
if ! command -v pip3 &> /dev/null; then
    echo "❌ pip3 is not installed. Installing pip3..."
    if [[ "$(uname -s)" == "Linux" ]]; then
        sudo apt-get update && sudo apt-get install -y python3-pip
    elif [[ "$(uname -s)" == "Darwin" ]]; then
        brew install python3
    else
        echo "❌ Please install pip3 manually for your OS."
        exit 1
    fi
fi

#arrduinocli
if ! command -v arduino-cli &> /dev/null; then
    echo "🔧 Arduino CLI not found. Installing Arduino CLI..."
#versiom
ARDUINO_CLI_VERSION=$(curl -s https://api.github.com/repos/arduino/arduino-cli/releases/latest | grep tag_name | cut -d '"' -f 4)
#OS&ARCH
    OS="$(uname -s)"
    ARCH="$(uname -m)"

    case "$OS" in
        "Linux")
            case "$ARCH" in
                "x86_64")   PLATFORM="Linux_64bit";;
                "aarch64")  PLATFORM="Linux_ARM64";;
                "armv7l")   PLATFORM="Linux_ARMv7";;
                *) echo "❌ Unsupported Linux architecture: $ARCH"; exit 1;;
            esac
            EXT="tar.gz"
            ;;
        "Darwin")
            case "$ARCH" in
                "x86_64")   PLATFORM="macOS_64bit";;
                "arm64")    PLATFORM="macOS_ARM64";;
                *) echo "❌ Unsupported macOS architecture: $ARCH"; exit 1;;
            esac
            EXT="tar.gz"
            ;;
        "MINGW"*|"MSYS"*|"CYGWIN"*|"Windows_NT")
            case "$ARCH" in
                "x86_64")   PLATFORM="Windows_64bit";;
                "arm64")    PLATFORM="Windows_ARM64";;
                *) echo "❌ Unsupported Windows architecture: $ARCH"; exit 1;;
            esac
            EXT="zip"
            ;;
        *)
            echo "❌ Unsupported OS: $OS"
            exit 1
            ;;
    esac

    FILE="arduino-cli_${ARDUINO_CLI_VERSION}_${PLATFORM}.${EXT}"
    URL="https://downloads.arduino.cc/arduino-cli/${ARDUINO_CLI_VERSION}/${FILE}"

    echo "⬇️  Downloading $FILE ..."
    wget "$URL"

    echo "📦 Extracting..."
    if [ "$EXT" = "tar.gz" ]; then
        tar -xzf "$FILE"
    else
        unzip "$FILE"
    fi

    echo "🚚 Installing..."
    if [[ "$OS" == "MINGW"* || "$OS" == "MSYS"* || "$OS" == "CYGWIN"* || "$OS" == "Windows_NT" ]]; then
        mv arduino-cli.exe /usr/local/bin/arduino-cli.exe
    else
        sudo mv arduino-cli /usr/local/bin/
    fi

    rm "$FILE"
    echo "✅ Arduino CLI installed."
fi
#esp8266
echo "🔧 Installing ESP8266 board support..."
arduino-cli core update-index
arduino-cli core install esp8266:esp8266
#
#
#
#
echo "✅ All dependencies installed!"
echo "✨ You can now use the tool:"
echo "   python3 ino_to_bin.py path/to/sketch.ino"
echo ""
echo "ℹ️  Make sure your .ino file is in a folder with the same name as the sketch!"
python3 ino2bin.py
