#!/bin/bash
set -e

# Node.js / npm のインストール（なければ）
if ! command -v npm &> /dev/null; then
    echo "Node.js/npm not found. Installing..."
    apt-get update -y
    apt-get install -y curl
    curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
    apt-get install -y nodejs
fi

# Codex CLI のインストール
npm install -g @openai/codex

# Claude Code のインストール
npm install -g @anthropic-ai/claude-code
