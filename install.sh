#/bin/sh

uv add vllm[bench,audio] transformers --pre \
  --index https://vllm.ai \
  --index https://download.pytorch.org/whl/nightly/cu132 \
  --index-strategy unsafe-best-match


#uv add vllm[bench,audio] --pre \
#  --index https://wheels.vllm.ai/nightly/cu129 \
#  --index https://download.pytorch.org/whl/cu129 \
#  --index-strategy unsafe-best-match

