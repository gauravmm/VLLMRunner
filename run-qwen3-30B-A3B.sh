#!/bin/sh

uv run vllm serve QuantTrio/Qwen3-VL-30B-A3B-Thinking-AWQ \
  --trust-remote-code \
  --max-model-len 24000 \
  --gpu-memory-utilization 0.95 \
  --served-model-name qwen3-vl-moe \
  --enable-auto-tool-choice \
  --tool-call-parser hermes \
  --reasoning-parser qwen3 \
  --enable-log-requests --enable-log-outputs
#  --chat-template ./qwen3.jinja2 \
