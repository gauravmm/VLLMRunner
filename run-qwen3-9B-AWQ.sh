#!/bin/sh

uv run vllm serve cyankiwi/Qwen3.5-9B-AWQ-BF16-INT4 \
  --trust-remote-code \
  --max-model-len 131072 \
  --gpu-memory-utilization 0.95 \
  --served-model-name qwen3.5-9b-awq \
  --kv-cache-dtype fp8 \
  --enable-auto-tool-choice \
  --tool-call-parser qwen3_xml \
  --reasoning-parser qwen3 \
  --enable-log-requests --enable-log-outputs
