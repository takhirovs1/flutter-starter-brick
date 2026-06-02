# Udevs Flutter Starter Brick

Standard Flutter project template for Udevs company.
One command to set up your entire development environment and create a production-ready Flutter project.

## Quick Start

    git clone https://github.com/takhirovs1/flutter-starter-brick.git
    cd flutter-starter-brick
    chmod +x create.sh
    ./create.sh

The project is created one level up from the brick folder.
Example: if you cloned into ~/Desktop/flutter-starter-brick and named your project shop_app,
the project will be at ~/Desktop/shop_app.

    cd ../shop_app
    cursor .
    flutter run

## What the Script Does

1. Detects your OS (macOS, Linux, Windows)
2. Checks and installs missing tools via Homebrew
3. Asks for project name (snake_case) and package name (e.g. io.udevs.shop_app)
4. iOS bundle ID is computed automatically (e.g. io.udevs.shopApp)
5. Generates the project with Mason brick
6. Runs flutter pub get and build_runner
7. Sets up FVM with pinned Flutter version

## Requirements

| Tool | Auto-install |
|------|:---:|
| Homebrew | Yes |
| Git | Yes |
| Xcode CLI Tools | Yes |
| Xcode.app | No (App Store) |
| Android Studio | Yes |
| FVM | Yes |
| Flutter 3.41.6 | Yes |
| CocoaPods | Yes |
| Mason CLI | Yes |
| Cursor / VS Code | No |

## Project Structure

    lib/src/
    +-- common/              Shared extensions, widgets, constants
    +-- core/
    |   +-- app/             App widget, splash, initialization
    |   +-- auth/            Session management
    |   +-- di/              GetIt dependency injection
    |   +-- error/           Error handling
    |   +-- localization/    l10n (uz, en, ru)
    |   +-- network/         Dio, interceptors
    |   +-- router/          GoRouter
    |   +-- theme/           Colors, text styles
    |   +-- widget/          Design system widgets
    +-- features/
        +-- auth/            Authentication
        +-- home/            Home screen
        +-- journal/         Journal
        +-- profile/         Profile
        +-- main/            Main shell (bottom nav)

Each feature:

    feature/
    +-- di/                  DI registration
    +-- data/                Models, datasources, repository impl
    +-- domain/              Entities, abstract repo, use cases
    +-- presentation/        Cubit/Bloc, screens, widgets

## AI Rules

Files: AGENTS.md, CLAUDE.md, .cursorrules

1. No dynamic -- use Object?
2. Dot shorthands mandatory
3. All strings via l10n (context.l10n.key) with uz/en/ru
4. No freezed/json_serializable -- manual models
5. Private _ only for class fields, not widgets/functions
6. Each widget in its own file
7. Cubit depends on UseCase, not Repository
8. Entity in domain, Model in data, never cross

Full rules: udevs_flutter_standards.md

## Updating the Brick

    git add . && git commit -m "brick: description"
    git tag v1.1.0
    git push origin main --tags

Update BRICK_REF in create.sh to match.

## Troubleshooting

Brick registration failed:

    mason remove -g core_app
    mason add -g core_app --git-url https://github.com/takhirovs1/flutter-starter-brick.git --git-ref v1.0.0

Flutter PATH warning -- add to ~/.zshrc:

    export PATH="\/Users/samandar/fvm/default/bin:\/Users/samandar/.antigravity-ide/antigravity-ide/bin:/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:/pkg/env/global/bin:/Library/Apple/usr/bin:/opt/homebrew/bin:/Users/samandar/.pub-cache/bin"

---

# O'zbek tilida

## Tez boshlash

    git clone https://github.com/takhirovs1/flutter-starter-brick.git
    cd flutter-starter-brick
    chmod +x create.sh
    ./create.sh

Loyiha brick papkasidan tashqarida yaratiladi.
Masalan brick ~/Desktop/flutter-starter-brick da, loyiha nomi shop_app bo'lsa:

    cd ../shop_app
    cursor .
    flutter run

## Skript nima qiladi

1. OS ni aniqlaydi
2. Kerakli vositalarni tekshiradi, yo'q bo'lsa o'rnatadi
3. Loyiha nomi va package name so'raydi
4. iOS bundle ID avtomatik hisoblanadi
5. Mason brick orqali loyiha yaratadi
6. flutter pub get va build_runner ishlaydi
7. FVM orqali Flutter versiyasini sozlaydi

## Talablar

| Vosita | Avtomatik |
|--------|:---------:|
| Homebrew | Ha |
| Git | Ha |
| Xcode CLI Tools | Ha |
| Xcode.app | Yo'q (App Store) |
| Android Studio | Ha |
| FVM | Ha |
| Flutter 3.41.6 | Ha |
| CocoaPods | Ha |
| Mason CLI | Ha |

## AI Qoidalari

1. dynamic yo'q -- Object? ishlating
2. Nuqta shorthands majburiy
3. Barcha matnlar l10n orqali (uz/en/ru)
4. freezed/json_serializable yo'q -- qo'lda modellar
5. Private _ faqat field uchun, widget/funksiya uchun emas
6. Har bir widget alohida faylda
7. Cubit UseCase ga bog'liq, Repository ga emas

To'liq: udevs_flutter_standards.md

## Litsenziya

Faqat ichki foydalanish. Udevs LLC.
