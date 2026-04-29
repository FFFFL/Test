#!/usr/bin/env bash
set -euo pipefail

INPUT=${1:-}
OUTPUT_DIR=${2:-/data/video/hls/demo}

if [[ -z "$INPUT" ]]; then
  echo "Usage: $0 <input.mp4> [output_dir]"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"
ffmpeg -i "$INPUT" \
  -c:v libx264 -c:a aac -preset veryfast -crf 23 \
  -hls_time 6 -hls_list_size 0 \
  -hls_segment_filename "$OUTPUT_DIR/seg_%05d.ts" \
  "$OUTPUT_DIR/index.m3u8"

echo "HLS output: $OUTPUT_DIR/index.m3u8"
