#!/bin/sh
export PYTORCH_ALLOC_CONF=expandable_segments:True

uv run vllm serve cyankiwi/gemma-4-26B-A4B-it-AWQ-4bit \
  --trust-remote-code \
  --enforce-eager \
  --max-model-len 32768 \
  --max-num-seqs 1 \
  --gpu-memory-utilization 0.95 \
  --served-model-name gemma-4-26B-A4B \
  --kv-cache-dtype fp8 \
  --enable-auto-tool-choice \
  --tool-call-parser gemma4 \
  --reasoning-parser gemma4 \
  --enable-chunked-prefill \
  --enable-log-requests
