#!/bin/sh

uv run vllm serve QuantTrio/GLM-4.7-Flash-AWQ \
  --trust-remote-code \
  --max-model-len 32768 \
  --gpu-memory-utilization 0.90 \
  --served-model-name glm-4.7-flash
