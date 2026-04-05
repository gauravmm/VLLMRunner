#!/bin/sh

uv run vllm serve google/gemma-4-e4b-it \
  --trust-remote-code \
  --max-model-len 131072 \
  --gpu-memory-utilization 0.90 \
  --served-model-name gemma-4-e4b \
  --kv-cache-dtype fp8 \
  --quantization fp8 \
  --enable-auto-tool-choice \
  --tool-call-parser gemma4 \
  --reasoning-parser gemma4 \
  --enable-chunked-prefill \
  --enable-log-requests
