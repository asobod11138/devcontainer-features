#!/bin/bash
set -e

# Node.js 20+ を保証（古い場合は更新）
REQUIRED_NODE_MAJOR=20
CURRENT_NODE_MAJOR=""
if command -v node &> /dev/null; then
    CURRENT_NODE_MAJOR="$(node -v 2>/dev/null | sed -E 's/^v([0-9]+).*/\1/')"
fi

if [ -z "${CURRENT_NODE_MAJOR}" ] || [ "${CURRENT_NODE_MAJOR}" -lt "${REQUIRED_NODE_MAJOR}" ]; then
    echo "Ensuring Node.js ${REQUIRED_NODE_MAJOR}.x (current: ${CURRENT_NODE_MAJOR:-not installed})"
    apt-get update -y
    apt-get install -y curl
    curl -fsSL "https://deb.nodesource.com/setup_${REQUIRED_NODE_MAJOR}.x" | bash -
    apt-get install -y nodejs
fi

# Codex CLI のインストール
npm install -g @openai/codex

# Claude Code のインストール
npm install -g @anthropic-ai/claude-code

# Claude コマンドを PATH で確実に見えるようにする
NPM_PREFIX="$(npm config get prefix)"
NPM_GLOBAL_BIN="${NPM_PREFIX}/bin"
mkdir -p /usr/local/bin
if ! command -v claude &> /dev/null; then
    if [ -x "${NPM_GLOBAL_BIN}/claude" ]; then
        ln -sf "${NPM_GLOBAL_BIN}/claude" /usr/local/bin/claude
    elif [ -x "${NPM_GLOBAL_BIN}/claude-code" ]; then
        ln -sf "${NPM_GLOBAL_BIN}/claude-code" /usr/local/bin/claude
    fi
fi
