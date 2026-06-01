# Udevs Flutter Starter Brick

Standard Flutter project template for Udevs. Mason brick + bootstrap script.

## Quick Start

    git clone https://github.com/udevs/flutter-starter-brick
    cd flutter-starter-brick
    chmod +x create.sh
    ./create.sh

The script automatically checks/installs all required tools (Homebrew, Git, Xcode CLI, Android Studio, FVM, Flutter, CocoaPods, Mason), asks for project name and package name, then creates a production-ready Flutter project with Clean Architecture.

## Requirements

| Tool | Auto-install? |
|------|---------------|
| Homebrew | Yes |
| Git | Yes |
| Xcode CLI Tools | Yes |
| Xcode.app | No (App Store) |
| Android Studio | Yes (brew) |
| FVM | Yes |
| Flutter 3.41.6 | Yes |
| CocoaPods | Yes |
| Mason CLI | Yes |

## AI Rules

- AGENTS.md — Full architecture and code rules
- CLAUDE.md — Claude AI instructions
- .cursorrules — Cursor IDE rules

Key: No dynamic (use Object?), dot shorthands, l10n mandatory, no freezed, each widget in own file.

## Updating

    git add . && git commit -m "brick: desc"
    git tag v1.1.0
    git push origin main --tags

Then update BRICK_REF in create.sh.

## License

Internal use only — Udevs LLC.
