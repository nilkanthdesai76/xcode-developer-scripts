#!/usr/bin/env bash
# ==============================================================================
# Git Patch Helper Script
# Automates generating, validating, and applying Git format-patches
# ==============================================================================

set -euo pipefail

COMMAND="${1:-help}"

case "$COMMAND" in
    "create")
        TARGET_BRANCH="${2:-main}"
        OUTPUT_DIR="${3:-./patches}"
        mkdir -p "$OUTPUT_DIR"
        echo "📦 Creating patch files against branch '$TARGET_BRANCH' into '$OUTPUT_DIR'..."
        git format-patch "$TARGET_BRANCH" -o "$OUTPUT_DIR"
        echo "✓ Patches generated in $OUTPUT_DIR"
        ;;
    "commit")
        COMMIT_HASH="${2:-}"
        OUTPUT_DIR="${3:-./patches}"
        if [ -z "$COMMIT_HASH" ]; then
            echo "Error: Commit hash required. Usage: $0 commit <commit-hash> [output_dir]"
            exit 1
        fi
        mkdir -p "$OUTPUT_DIR"
        echo "📦 Creating patch for single commit '$COMMIT_HASH'..."
        git format-patch -1 "$COMMIT_HASH" -o "$OUTPUT_DIR"
        echo "✓ Patch generated in $OUTPUT_DIR"
        ;;
    "apply")
        PATCH_FILE="${2:-}"
        if [ -z "$PATCH_FILE" ]; then
            echo "Error: Patch file required. Usage: $0 apply <path/to/file.patch>"
            exit 1
        fi
        echo "📥 Applying patch '$PATCH_FILE' via git am..."
        git am "$PATCH_FILE"
        echo "✓ Successfully applied patch."
        ;;
    "diff")
        OUTPUT_FILE="${2:-changes.patch}"
        echo "📄 Exporting unstaged & staged working tree diff to '$OUTPUT_FILE'..."
        git diff HEAD > "$OUTPUT_FILE"
        echo "✓ Diff exported to $OUTPUT_FILE"
        ;;
    *)
        echo "Git Patch Helper"
        echo "Usage:"
        echo "  $0 create [target-branch] [output-dir]  Create patch series against a target branch"
        echo "  $0 commit <commit-hash> [output-dir]   Create patch for a specific commit"
        echo "  $0 apply <patch-file>                  Apply a patch cleanly via git am"
        echo "  $0 diff [filename.patch]               Export current working tree diff"
        ;;
esac
