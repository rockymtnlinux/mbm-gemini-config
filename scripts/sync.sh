#!/usr/bin/env bash
set -euo pipefail

# Determine script directory & repo root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Identify target Gemini directories (both Windows user profile and Linux home if in WSL)
TARGET_DIRS=()

# 1. Check for Windows user profile mount in WSL / Git Bash
if [ -d "/mnt/c/Users/rocky/.gemini" ]; then
    TARGET_DIRS+=("/mnt/c/Users/rocky/.gemini")
elif [ -d "/c/Users/rocky/.gemini" ]; then
    TARGET_DIRS+=("/c/Users/rocky/.gemini")
elif [ -n "${USERPROFILE:-}" ]; then
    WIN_GEMINI="$(wslpath "${USERPROFILE}/.gemini" 2>/dev/null || echo "${USERPROFILE}/.gemini")"
    TARGET_DIRS+=("${WIN_GEMINI}")
fi

# 2. Check for Linux HOME
if [ -d "${HOME}/.gemini" ] || [ ! -d "/mnt/c/Users/rocky/.gemini" ]; then
    TARGET_DIRS+=("${HOME}/.gemini")
fi

echo "==> Synchronizing mbm-gemini-config..."

for DEST in "${TARGET_DIRS[@]}"; do
    echo " -> Target: ${DEST}"
    SKILLS_DEST="${DEST}/config/skills"
    
    mkdir -p "${DEST}"
    mkdir -p "${SKILLS_DEST}"
    
    # 1. Sync global guidelines
    cp "${REPO_ROOT}/GLOBAL_GUIDELINES.md" "${DEST}/GEMINI.md"
    echo "    ✓ Updated ${DEST}/GEMINI.md"
    
    # 2. Sync shared skills
    if [ -d "${REPO_ROOT}/skills" ]; then
        cp -r "${REPO_ROOT}/skills/"* "${SKILLS_DEST}/"
        echo "    ✓ Updated ${SKILLS_DEST}/"
    fi
done

echo "==> Synchronization complete!"
