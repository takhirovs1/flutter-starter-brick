# Udevs Flutter Starter Brick

Standard Flutter project template for Udevs company.
One command to set up your entire development environment and create a production-ready Flutter project.

---

## Table of Contents

- [Quick Start](#quick-start)
- [What the Script Does](#what-the-script-does)
- [Requirements](#requirements)
- [Project Structure](#project-structure)
- [AI Development Rules](#ai-development-rules)
- [Updating the Brick](#updating-the-brick)
- [Troubleshooting](#troubleshooting)
- [O'zbek tilida](#ozbek-tilida)

---

## Quick Start

### Step 1: Clone this repository

    git clone https://github.com/takhirovs1/flutter-starter-brick.git
    cd flutter-starter-brick

### Step 2: Run the bootstrap script

    chmod +x create.sh
    ./create.sh

### Step 3: Open your project

The project is created one level up from the brick folder (not inside it).
For example, if you cloned into ~/Desktop/flutter-starter-brick and named your project shop_app,
the project will be at ~/Desktop/shop_app.

    cd ../shop_app
    cursor .

To run the app:

    flutter run

---

## What the Script Does

The script performs these steps automatically:

1. Detects your operating system (macOS, Linux, Windows)
2. Checks for required development tools
3. Installs any missing tools via Homebrew (macOS)
4. Asks you for project details:
   - Project name (snake_case, e.g. shop_app)
   - Package name (e.g. io.udevs.shop_app)
   - iOS bundle ID is computed automatically (e.g. io.udevs.shopApp)
5. Shows a summary and asks for confirmation
6. Generates the project using Mason brick
7. Runs flutter pub get and build_runner automatically
8. Sets up FVM with the pinned Flutter version

---

## Requirements

The script checks and installs these automatically:

| Tool              | Description                  | Auto-install |
|-------------------|------------------------------|:------------:|
| Homebrew          | macOS package manager        | Yes          |
| Git               | Version control              | Yes          |
| Xcode CLI Tools   | iOS build tools              | Yes          |
| Xcode.app         | Full iOS builds              | No*          |
| Android Studio    | Android SDK                  | Yes          |
| FVM               | Flutter version manager      | Yes          |
| Flutter 3.41.6    | SDK (installed via FVM)      | Yes          |
| CocoaPods         | iOS dependency manager       | Yes          |
| Mason CLI         | Code generator               | Yes          |
| Cursor / VS Code  | Code editor                  | No*          |

*Xcode.app must be installed from the App Store manually.
*Cursor or VS Code should be installed separately.

---

## Project Structure

Every generated project follows Clean Architecture + BLoC/Cubit + Feature-first:

    lib/src/
    +-- common/                  Shared extensions, widgets, constants
    +-- core/
    |   +-- app/                 App widget, splash screen, initialization
    |   +-- auth/                Session management
    |   +-- di/                  GetIt dependency injection
    |   +-- error/               Error handling, failures
    |   +-- localization/        l10n with uz, en, ru support
    |   +-- network/             Dio client, interceptors
    |   +-- router/              GoRouter navigation
    |   +-- theme/               Colors, text styles, theme data
    |   +-- widget/              Reusable design system widgets
    +-- features/
        +-- auth/                Authentication feature
        +-- home/                Home screen
        +-- journal/             Journal feature
        +-- profile/             Profile feature
        +-- main/                Main shell with bottom navigation

Each feature follows the same internal structure:

    feature/
    +-- di/                      Feature DI registration
    +-- data/
    |   +-- datasources/         Remote, local, mock
    |   +-- models/              DTOs with fromJson/toJson/toEntity
    |   +-- repository/          Repository implementation
    +-- domain/
    |   +-- entities/            Pure Dart entities
    |   +-- repository/          Abstract repository interface
    |   +-- usecase/             Single-purpose use cases
    |   +-- error/               Feature-specific exceptions
    +-- presentation/
        +-- cubit/ (or bloc/)    State management
        +-- screen/              Screen widgets
        +-- state/               Screen state classes
        +-- widget/              Feature-specific widgets (each in own file)

---

## AI Development Rules

The project includes three AI configuration files:

- AGENTS.md: Complete architecture and coding rules
- CLAUDE.md: Claude-specific instructions
- .cursorrules: Cursor IDE quick rules

### Key Rules

1. No dynamic anywhere. Use Object? instead.
2. Dot shorthands mandatory: .center, .loading, const .all(8)
3. All user-facing strings via l10n (context.l10n.keyName) with proper uz/en/ru translations
4. No freezed, json_serializable, retrofit, or injectable. Manual models only.
5. Private _ only for class fields (_repository, _controller). Never for widgets or functions.
6. Each widget in its own file under presentation/widget/
7. Cubit depends on UseCase, never directly on Repository
8. Entities in domain (pure Dart), Models in data. Never cross layers.

Full rules: see udevs_flutter_standards.md in this repository.

---

## Updating the Brick

When the template needs changes (maintainer only):

1. Update files in the __brick__ directory
2. Commit and tag:

       git add . && git commit -m "brick: description of change"
       git tag v1.1.0
       git push origin main --tags

3. Update BRICK_REF in create.sh to the new tag
4. Commit and push create.sh

Team members will automatically get the new version on their next project creation.

---

## Troubleshooting

Problem: Brick registration failed
Solution: Make sure the repository is accessible. Try manually:

    mason remove -g core_app
    mason add -g core_app --git-url https://github.com/takhirovs1/flutter-starter-brick.git --git-ref v1.0.0

Problem: Flutter PATH warning
Solution: Add to ~/.zshrc:

    export PATH="$HOME/fvm/default/bin:$PATH"

Then restart your terminal or run: source ~/.zshrc

Problem: flutter analyze shows errors after generation
Solution: Run:

    flutter pub get
    dart run build_runner build --delete-conflicting-outputs

---

## License

Internal use only. Udevs LLC. All rights reserved.

---
---

# O'zbek tilida

## Udevs Flutter Starter Brick

Udevs kompaniyasi uchun standart Flutter loyiha shabloni.
Bitta komanda bilan butun dasturlash muhitini sozlab, tayyor loyiha yaratadi.

---

## Tez boshlash

### 1-qadam: Reponi klonlang

    git clone https://github.com/takhirovs1/flutter-starter-brick.git
    cd flutter-starter-brick

### 2-qadam: Skriptni ishga tushiring

    chmod +x create.sh
    ./create.sh

### 3-qadam: Loyihani oching

Loyiha brick papkasidan tashqarida yaratiladi.
Masalan, brick ~/Desktop/flutter-starter-brick da bo'lsa va loyiha nomi shop_app bo'lsa,
loyiha ~/Desktop/shop_app da bo'ladi.

    cd ../shop_app
    cursor .

Ilovani ishga tushirish:

    flutter run

---

## Skript nima qiladi

1. Operatsion tizimni aniqlaydi (macOS, Linux, Windows)
2. Kerakli vositalarni tekshiradi
3. Yo'q bo'lsa Homebrew orqali o'rnatadi (macOS)
4. Loyiha ma'lumotlarini so'raydi:
   - Loyiha nomi (snake_case, masalan shop_app)
   - Package name (masalan io.udevs.shop_app)
   - iOS bundle ID avtomatik hisoblanadi (masalan io.udevs.shopApp)
5. Xulosani ko'rsatib, tasdiqlash so'raydi
6. Mason brick orqali loyihani yaratadi
7. flutter pub get va build_runner avtomatik ishlaydi
8. FVM orqali Flutter versiyasini sozlaydi

---

## Talablar

Skript quyidagilarni avtomatik tekshiradi va o'rnatadi:

| Vosita            | Tavsif                       | Avtomatik |
|-------------------|------------------------------|:---------:|
| Homebrew          | macOS paket menejeri         | Ha        |
| Git               | Versiya boshqarish           | Ha        |
| Xcode CLI Tools   | iOS build vositalari         | Ha        |
| Xcode.app         | To'liq iOS build             | Yo'q*     |
| Android Studio    | Android SDK                  | Ha        |
| FVM               | Flutter versiya boshqarish   | Ha        |
| Flutter 3.41.6    | SDK (FVM orqali)             | Ha        |
| CocoaPods         | iOS dependency menejeri      | Ha        |
| Mason CLI         | Kod generatori               | Ha        |
| Cursor / VS Code  | Kod muharriri                | Yo'q*     |

*Xcode.app — App Store'dan qo'lda o'rnating.
*Cursor yoki VS Code — alohida o'rnating.

---

## Loyiha Strukturasi

Yaratilgan har bir loyiha Clean Architecture + BLoC/Cubit + Feature-first uslubida:

    lib/src/
    +-- common/                  Umumiy yordamchilar
    +-- core/
    |   +-- app/                 App widget, splash, initsializatsiya
    |   +-- auth/                Sessiya boshqarish
    |   +-- di/                  GetIt (dependency injection)
    |   +-- error/               Xato boshqarish
    |   +-- localization/        l10n (uz, en, ru)
    |   +-- network/             Dio, interceptorlar
    |   +-- router/              GoRouter navigatsiya
    |   +-- theme/               Ranglar, shriftlar, tema
    |   +-- widget/              Qayta ishlatiladigan widgetlar
    +-- features/
        +-- auth/                Autentifikatsiya
        +-- home/                Bosh ekran
        +-- journal/             Jurnal
        +-- profile/             Profil
        +-- main/                Asosiy shell (bottom navigation)

Har bir feature ichki strukturasi:

    feature/
    +-- di/                      Feature DI ro'yxatga olish
    +-- data/
    |   +-- datasources/         Remote, local, mock
    |   +-- models/              DTO: fromJson/toJson/toEntity
    |   +-- repository/          Repository implementatsiya
    +-- domain/
    |   +-- entities/            Sof Dart entitylar
    |   +-- repository/          Abstrakt repository interfeys
    |   +-- usecase/             Bitta vazifali use case'lar
    |   +-- error/               Feature xatolari
    +-- presentation/
        +-- cubit/ (yoki bloc/)  State boshqarish
        +-- screen/              Ekran widgetlari
        +-- state/               Ekran state klasslari
        +-- widget/              Feature widgetlari (har biri alohida faylda)

---

## AI Dasturlash Qoidalari

Loyihada uchta AI qoidalar fayli bor:

- AGENTS.md: To'liq arxitektura va kod qoidalari
- CLAUDE.md: Claude AI uchun qo'shimcha ko'rsatmalar
- .cursorrules: Cursor IDE qoidalari

### Asosiy qoidalar

1. dynamic hech qayerda ishlatilmasin. Object? ishlating.
2. Nuqta shorthands majburiy: .center, .loading, const .all(8)
3. Barcha foydalanuvchi matnlari l10n orqali (context.l10n.keyName), uz/en/ru tarjimalari bilan
4. freezed, json_serializable, retrofit, injectable ishlatilmasin. Modellar qo'lda yoziladi.
5. Private _ faqat klass field'lari uchun (_repository, _controller). Widget va funksiyalar uchun emas.
6. Har bir widget alohida faylda presentation/widget/ ichida
7. Cubit UseCase'ga bog'liq, hech qachon to'g'ridan-to'g'ri Repository'ga emas
8. Entity domain'da (sof Dart), Model data'da. Qatlamlarni aralashtirma.

To'liq qoidalar: udevs_flutter_standards.md faylida.

---

## Brick'ni yangilash

Shablonni o'zgartirish kerak bo'lganda (faqat maintainer):

1. __brick__ papkasidagi fayllarni yangilang
2. Commit va tag qo'ying:

       git add . && git commit -m "brick: o'zgarish tavsifi"
       git tag v1.1.0
       git push origin main --tags

3. create.sh dagi BRICK_REF ni yangi tag'ga o'zgartiring
4. create.sh ni commit va push qiling

Jamoa a'zolari keyingi loyiha yaratganda avtomatik yangi versiyani oladi.

---

## Muammolarni hal qilish

Muammo: Brick registration failed
Yechim: Qo'lda sinab ko'ring:

    mason remove -g core_app
    mason add -g core_app --git-url https://github.com/takhirovs1/flutter-starter-brick.git --git-ref v1.0.0

Muammo: Flutter PATH ogohlantirishi
Yechim: ~/.zshrc ga qo'shing:

    export PATH="$HOME/fvm/default/bin:$PATH"

Keyin terminalni qayta oching yoki: source ~/.zshrc

Muammo: flutter analyze xato ko'rsatadi
Yechim:

    flutter pub get
    dart run build_runner build --delete-conflicting-outputs

---

## Litsenziya

Faqat ichki foydalanish uchun. Udevs LLC. Barcha huquqlar himoyalangan.
