#!/usr/bin/env bash

# Script to normalize audio in video files
# Usage: ./normalize-audio-youtube.sh <input_video_file...>

set -euo pipefail

readonly HOMEBREW_PATH="/opt/homebrew/bin"
readonly LOCAL_BIN_PATH="$HOME/.local/bin"

check_ffmpeg_normalize() {
    if command -v ffmpeg-normalize &>/dev/null; then
        return 0
    fi

    # Try adding local bin to PATH
    export PATH="$LOCAL_BIN_PATH:$PATH"
    if command -v ffmpeg-normalize &>/dev/null; then
        return 0
    fi

    echo "Error: ffmpeg-normalize not found"
    echo "Please install it using: python3 -m pip install ffmpeg-normalize"
    return 1
}

check_ffmpeg() {
    if ! command -v ffmpeg &>/dev/null; then
        # Try homebrew path
        export PATH="$HOMEBREW_PATH:$PATH"
        if ! command -v ffmpeg &>/dev/null; then
            echo "Error: ffmpeg not found"
            echo "Please install it using: brew install ffmpeg"
            return 1
        fi
    fi
}

check_dependencies() {
    check_ffmpeg || exit 1
    check_ffmpeg_normalize || exit 1
}

validate_input() {
    if [[ $# -lt 1 ]]; then
        echo "Error: Missing input file(s)"
        echo "Usage: $(basename "$0") <input_video_file...>"
        exit 1
    fi

    for input_file in "$@"; do
        if [[ ! -f "$input_file" ]]; then
            echo "Error: File not found: $input_file"
            exit 1
        fi
    done
}

generate_output_filename() {
    local input_file="$1"
    local filename="${input_file%.*}"
    local extension="${input_file##*.}"
    echo "${filename}_normalized.${extension}"
}

normalize_audio() {
    local input_file="$1"
    local output_file="$2"

    export PATH="$HOMEBREW_PATH:$PATH"
    # Use -c:a aac if extension is mp4
    if [[ "$input_file" == *.mp4 ]]; then
        ffmpeg-normalize "$input_file" -c:a aac -o "$output_file"
        return
    else
        ffmpeg-normalize "$input_file" -o "$output_file"
        return
    fi
}

main() {
    check_dependencies
    validate_input "$@"

    local total_files=$#
    local current_file=1

    for input_file in "$@"; do
        echo "Processing file $current_file of $total_files: $input_file"
        
        local output_file
        output_file=$(generate_output_filename "$input_file")

        normalize_audio "$input_file" "$output_file"
        echo "NOTIFICATION:Audio normalized: $output_file"
        
        ((current_file++))
    done
    
    echo "QUITAPP"
    echo
}

main "$@"
