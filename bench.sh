#/bin/sh

uv run vllm bench serve \
  --model google/gemma-4-12B-it-qat-w4a16-ct \
  --port 8139 \
  --dataset-name sharegpt \
  --dataset-path ./ShareGPT_V3_unfiltered_cleaned_split.json \
  --num-prompts 500 \
  --request-rate 4
