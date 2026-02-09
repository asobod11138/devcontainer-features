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

# Claude コマンドを PATH で確実に見えるようにする
NPM_GLOBAL_BIN="$(npm bin -g)"
mkdir -p /usr/local/bin
if ! command -v claude &> /dev/null; then
    if [ -x "${NPM_GLOBAL_BIN}/claude" ]; then
        ln -sf "${NPM_GLOBAL_BIN}/claude" /usr/local/bin/claude
    elif [ -x "${NPM_GLOBAL_BIN}/claude-code" ]; then
        ln -sf "${NPM_GLOBAL_BIN}/claude-code" /usr/local/bin/claude
    fi
fi
