#!/bin/sh

uv run vllm serve google/gemma-4-12B-it-qat-w4a16-ct \
  --trust-remote-code \
  --max-model-len 24000 \
  --gpu-memory-utilization 0.90 \
  --served-model-name google/gemma-4-12B-it \
  --dtype bfloat16 \
  --hf-overrides '{"vision_config": {"num_soft_tokens": 280}}' \
  --enable-auto-tool-choice \
  --tool-call-parser gemma4 \
  --reasoning-parser gemma4 \
  --enable-chunked-prefill \
  --enable-log-requests \
  --enable-prefix-caching \
  --max-num-seqs 16 \
  --max-num-batched-tokens 24000 \
  --language-model-only \
  --port 8139
