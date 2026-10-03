#!/usr/bin/env python3
"""
Batch rename custom color asset references across Xcode Storyboard and XIB files.
"""

import os
import fileinput
import argparse

def rename_color_assets(directory: str, old_name: str, new_name: str):
    file_extensions = [".storyboard", ".xib"]
    modified_files = 0

    print(f"🔍 Searching for '{old_name}' to rename to '{new_name}' in: {directory}")

    for root, _, files in os.walk(directory, topdown=False):
        for file_name in files:
            if any(file_name.endswith(ext) for ext in file_extensions):
                file_path = os.path.join(root, file_name)
                found = False

                with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
                    content = f.read()
                    if old_name in content:
                        found = True

                if found:
                    for line in fileinput.input(file_path, inplace=True):
                        print(line.replace(old_name, new_name), end="")
                    print(f"  ✓ Updated: {file_path}")
                    modified_files += 1

    print(f"\n✨ Completed! Successfully updated {modified_files} file(s).")

def main():
    parser = argparse.ArgumentParser(description="Rename custom color asset references in Xcode Storyboards and XIBs.")
    parser.add_argument("--old", required=True, help="Current name of the color asset")
    parser.add_argument("--new", required=True, help="New target name for the color asset")
    parser.add_argument("--dir", default=".", help="Project directory to scan (default: current directory)")
    args = parser.parse_args()

    rename_color_assets(args.dir, args.old, args.new)

if __name__ == "__main__":
    main()
