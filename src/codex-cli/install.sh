#!/usr/bin/env bash
set -euo pipefail

# Ensure npm is available (Node feature installs it)
if ! command -v npm >/dev/null 2>&1; then
  echo "Node/npm not found. Add ghcr.io/devcontainers/features/node:1 to this devcontainer."
  exit 1
fi

# Install Codex CLI (official)
npm install -g @openai/codex

# Persist API key if provided
if [ -n "${OPENAI_API_KEY:-}" ]; then
  # For login shells
  echo "export OPENAI_API_KEY='${OPENAI_API_KEY}'" | tee /etc/profile.d/openai.sh >/dev/null
  chmod 0755 /etc/profile.d/openai.sh
fi

echo "Codex CLI installed. Version: $(codex --version || true)"
