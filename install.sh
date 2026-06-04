#/bin/sh

uv add vllm[bench,audio] --pre \
  --index https://wheels.vllm.ai/nightly/cu129 \
  --index https://download.pytorch.org/whl/cu129 \
  --index-strategy unsafe-best-match

