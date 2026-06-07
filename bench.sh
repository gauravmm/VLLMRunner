#/bin/sh

uv run vllm bench serve \
  --model google/gemma-4-12B-it \
  --port 8139 \
  --dataset-name sharegpt \
  --dataset-path ./ShareGPT_V3_unfiltered_cleaned_split.json \
  --num-prompts 500 \
  --request-rate 4 \
  --temperature 1.0 \
  --sharegpt-output-len 512 \
  --percentile-metrics ttft,tpot,itl,e2el \
  --metric-percentiles 90,95,99
