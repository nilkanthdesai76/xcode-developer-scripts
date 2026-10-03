# Xcode Developer Scripts 🛠️

[![CI](https://github.com/nilkanthdesai76/xcode-developer-scripts/actions/workflows/ci.yml/badge.svg)](https://github.com/nilkanthdesai76/xcode-developer-scripts/actions)
A collection of battle-tested automation scripts and CLI utilities for Apple platforms engineers (iOS, macOS, visionOS).

[![Platform](https://img.shields.io/badge/Platform-macOS%2012%2B-blue?style=flat-square&logo=apple)](https://developer.apple.com/macos)
[![Python](https://img.shields.io/badge/Python-3.8%2B-brightgreen?style=flat-square&logo=python)](https://python.org)
[![Shell](https://img.shields.io/badge/Shell-Bash%20%7C%20Zsh-orange?style=flat-square&logo=gnubash)](https://www.gnu.org/software/bash/)
[![License: MIT](https://img.shields.io/badge/License-MIT-lightgrey?style=flat-square)](LICENSE)

<p align="center">
  <img src="assets/dev_scripts_diagram.svg" alt="Xcode Developer Scripts Overview" width="100%"/>
</p>

---

## 📑 Included Scripts

| Script | Language | Description |
| :--- | :--- | :--- |
| **`rename_color_assets.py`** | Python | Batch searches and renames color asset references across `.storyboard` and `.xib` files when assets are renamed. |
| **`build_xcframework.sh`** | Bash | Compiles iOS device and simulator slices and bundles them into a universal binary `.xcframework`. |
| **`git_patch_helper.sh`** | Bash | Automates generating and applying `git format-patch` series for code reviews and offline transfers. |

---

## 🚀 Usage

### 1. Batch Rename Storyboard Color Assets

When you rename a color asset in `Assets.xcassets`, Storyboards and XIBs often break with invalid color references. Run:

```sh
python3 scripts/rename_color_assets.py --old OldBrandColor --new NewBrandColor --dir ./MyApp
```

### 2. Build Universal XCFramework

```sh
chmod +x scripts/build_xcframework.sh
./scripts/build_xcframework.sh MyFramework MyFramework.xcodeproj
```

The compiled `.xcframework` will be generated in `./build/xcframework/MyFramework.xcframework`.

### 3. Git Patch Automation

```sh
chmod +x scripts/git_patch_helper.sh

# Create patches against main branch
./scripts/git_patch_helper.sh create main ./patches

# Create patch for specific commit
./scripts/git_patch_helper.sh commit a1b2c3d ./patches

# Apply patch
./scripts/git_patch_helper.sh apply ./patches/0001-my-feature.patch
```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
