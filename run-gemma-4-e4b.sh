#!/bin/sh

uv run vllm serve google/gemma-4-e4b-it \
  --trust-remote-code \
  --max-model-len 24000 \
  --gpu-memory-utilization 0.90 \
  --served-model-name google/gemma-4-e4b-it \
  --kv-cache-dtype fp8 \
  --quantization fp8 \
  --enable-auto-tool-choice \
  --tool-call-parser gemma4 \
  --reasoning-parser gemma4 \
  --enable-chunked-prefill \
  --enable-log-requests \
  --enable-prefix-caching \
  --max-num-seqs 32 \
  --max-num-batched-tokens 24000 \
  --speculative-config '{"model": "gg-hf-am/gemma-4-E4B-it-assistant", "num_speculative_tokens": 4}' \
  --port 8139
