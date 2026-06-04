#/bin/sh

uv run vllm bench serve \
  --model google/gemma-4-e4b-it \
  --port 8139 \
  --dataset-name sharegpt \
  --dataset-path ./ShareGPT_V3_unfiltered_cleaned_split.json \
  --num-prompts 2000 \
  --request-rate inf
