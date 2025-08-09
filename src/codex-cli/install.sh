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

# OPENAI_API_KEYが指定されていれば環境変数を設定
if [ -n "$OPENAI_API_KEY" ]; then
    echo "export OPENAI_API_KEY=$OPENAI_API_KEY" >> /etc/bash.bashrc
fi
