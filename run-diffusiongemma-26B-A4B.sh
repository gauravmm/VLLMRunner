#!/bin/sh

# =============================================================================
# DiffusionGemma 26B-A4B runner (saved 2026-06-11) — served via llama.cpp, NOT vLLM.
#
# BENCHMARK RESULT (bench.sh: 500 ShareGPT prompts, request-rate 4, output-len 512):
#   - 500/500 successful, 0 failed; duration ~35 min (2123 s)
#   - Output token throughput (system): 75.97 tok/s   <-- headline avg tok/s
#   - Generation/decode (token-weighted): ~76 tok/s; per-request median ~81 tok/s
#   - Total throughput (in+out): 130.17 tok/s; generated 161,283 tokens
#   - TTFT/E2EL means (~990 s) are QUEUE wait, not gen latency (single slot, 4 req/s).
#     TPOT/ITL ~0 because diffusion emits the whole 256-token canvas at once.
#
# MODEL / QUANT:
#   - Model:     diffusiongemma-26B-A4B-it (unsloth GGUF), Q4_K_M = 4-bit weights (~16 GB)
#   - KV cache:  F16 (llama.cpp default, NOT quantized); n_ctx 4096, canvas 256, ~48 steps/block
#   - VRAM:      ~20.4 GB / 24 GB on the RTX 4090
#
# WHY NOT vLLM (RTX 4090 = Ada, sm_89):
#   - NVFP4 MoE kernels require sm_90/sm_100 (Blackwell); the 4090 has no FP4 tensor cores.
#   - FP8 (~26 GB) and BF16 (~50 GB) weights exceed 24 GB VRAM.
#   - vLLM has no released/nightly diffusion-gemma support (only unmerged PR #45163).
#   - So served via a CUDA build of llama.cpp PR #24427 (OpenAI-compatible block-diffusion
#     server) in ../llamacpp-diffusion, with three local patches:
#       1. tensor name self_cond_norm -> self_cond_pre_norm (match unsloth GGUF)
#       2. tolerate the unused per-layer enc_layer_output_scale tensors
#       3. SSE streaming on /v1/completions (vllm bench serve always streams there)
#   - Stack add: cmake 4.3.2 (uv tool install cmake). vLLM/transformers UNCHANGED — vLLM is
#     used only as the bench client. Weights: unsloth Q4_K_M GGUF (16 GB) in the HF cache.
#
# SPEEDUP NOTES:
#   - Server is SINGLE-SLOT by design (mutex-serialized one context); --parallel/-np is a no-op.
#     Two server processes don't fit (2 x 16 GB > 24 GB). GPU was 99% busy throughout the run,
#     so the bottleneck is single-stream generation cost, not queuing.
#   - Cheapest real lever: fewer denoise steps (--diffusion-steps, default 128; model early-stops
#     ~48/block) trades a little quality for near-proportional tok/s. Bigger win would need true
#     in-server micro-batching (multi-canvas decode), a substantial change to the draft PR.
# =============================================================================

LLAMA_DIR="$HOME/benchclaw_orchestration/llamacpp-diffusion"

# Resolve the cached GGUF path (downloads on first run) via the project's huggingface_hub.
GGUF="$(uv run python -c "from huggingface_hub import hf_hub_download; print(hf_hub_download('unsloth/diffusiongemma-26B-A4B-it-GGUF', 'diffusiongemma-26B-A4B-it-Q4_K_M.gguf'))")"

export PATH="/usr/local/cuda/bin:$PATH"
exec "$LLAMA_DIR/build/bin/llama-diffusion-gemma-server" \
  -m "$GGUF" \
  -ngl 99 \
  --host 127.0.0.1 \
  --port 8139 \
  -c 4096
