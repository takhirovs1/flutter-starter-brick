# Dart & Flutter MCP Server

> **Source:** [docs.flutter.dev/ai/mcp-server](https://docs.flutter.dev/ai/mcp-server)  
> **Status:** Experimental (requires Dart 3.9+)

---

## What is MCP?

**MCP (Model Context Protocol)** is an open standard protocol created by Anthropic. It acts as a bridge between AI assistants (Cursor, Claude Code, Windsurf, etc.) and development tools.

Before MCP, AI could only suggest code. With MCP, the AI agent can:
- Run terminal commands
- Read and modify files
- Inspect a running Flutter app
- Search pub.dev for packages
- Run tests and analyze results

All of this **autonomously** — you describe the goal, the agent handles execution.

---

## What can the Dart & Flutter MCP Server do?

27 tools are available. The key ones:

### Code analysis & error fixing
- Runs Dart analyzer to find all errors and warnings
- Automatically applies fixes
- Resolves symbols (classes, methods, variables) — checks existence, fetches docs and signatures

### Interact with a running app
- Reads the live **widget tree** of your running Flutter app
- Catches **runtime errors** (e.g. RenderFlex overflow) and fixes them in real time
- Inspects app state and render tree

### Package management
- Searches **pub.dev** for the right package (sorted by rating and popularity)
- Adds dependencies to `pubspec.yaml` automatically
- Writes the boilerplate code

### Tests & formatting
- Runs tests and analyzes results
- Formats code using the same rules as `dart format`

---

## Setup

**Requirement:** Dart 3.9 or later

```bash
dart --version
```

---

### Cursor

**Global** (applies to all projects) — `~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "dart": {
      "command": "dart",
      "args": ["mcp-server"]
    }
  }
}
```

**Local** (applies only to this project) — `.cursor/mcp.json` in project root:

```json
{
  "mcpServers": {
    "dart": {
      "command": "dart",
      "args": ["mcp-server"]
    }
  }
}
```

After saving, **restart Cursor**. Go to Settings → Tools & MCPs — you should see `dart — 27 tools enabled`.

---

### VS Code + GitHub Copilot

Dart extension v3.116+ is required.

Add to `settings.json`:

```json
"dart.mcpServer": true
```

---

### Claude Code

```bash
claude mcp add --transport stdio dart -- dart mcp-server
```

---

### Windsurf

`.codeium/windsurf/mcp_config.json`:

```json
{
  "mcpServers": {
    "dart-mcp-server": {
      "command": "dart",
      "args": ["mcp-server"]
    }
  }
}
```

---

### Gemini CLI

`~/.gemini/settings.json`:

```json
{
  "mcpServers": {
    "dart": {
      "command": "dart",
      "args": ["mcp-server"]
    }
  }
}
```

---

## How to use it

Once MCP is set up, use natural language in Agent mode. The AI decides which tools to call and when.

---

### Example 1 — Fix all analyzer errors

```
Analyze my project and fix all dart errors
```

What the AI does behind the scenes:
1. Runs `flutter analyze`
2. Collects all errors
3. Edits the relevant files
4. Re-analyzes to verify

---

### Example 2 — Fix a runtime layout error (RenderFlex overflow)

While the app is running:

```
Check for and fix static and runtime analysis issues.
Check for and fix any layout issues.
```

What the AI does:
1. Reads runtime errors from the running app
2. Inspects the widget tree to find the overflow cause
3. Applies a fix
4. Verifies no errors remain

---

### Example 3 — Find and add a package

```
Find a suitable package to add a line chart that
maps the number of button presses over time.
```

What the AI does:
1. Searches pub.dev using `pub_dev_search`
2. Suggests the best match (e.g. `fl_chart`)
3. On your confirmation, adds it to `pubspec.yaml`
4. Writes the boilerplate widget code
5. Self-corrects any syntax errors

---

### Example 4 — Run tests

```
Run all tests and show me which ones are failing
```

---

### Example 5 — Format code

```
Format all dart files in the lib folder
```

---

## Useful prompts

```
Analyze my project and fix all dart errors
```
```
Check for and fix any layout issues in the running app
```
```
Find the best package for local push notifications and add it
```
```
Run tests and fix the failing ones
```
```
Format all files and fix lint warnings
```
```
Add [package_name] and write a basic usage example
```

---

## Important notes

**Sandbox permission** — Cursor may ask for permission before running commands like `flutter analyze`. Click **Allow**.

**App must be running** — To use widget tree inspection and runtime error fixing, the app must be running in debug mode on a simulator or real device.

**Experimental** — Officially marked as experimental. Core features work reliably, but some tools may change.

**Roots fallback** — If your MCP client doesn't set roots correctly, add `--force-roots-fallback`:

```json
{
  "mcpServers": {
    "dart": {
      "command": "dart",
      "args": ["mcp-server", "--force-roots-fallback"]
    }
  }
}
```

---

## Resources

- Official docs: [docs.flutter.dev/ai/mcp-server](https://docs.flutter.dev/ai/mcp-server)
- Issue tracker: [github.com/dart-lang/ai/issues](https://github.com/dart-lang/ai/issues)

---

---

# Dart & Flutter MCP Server (O'zbekcha)

> **Manba:** [docs.flutter.dev/ai/mcp-server](https://docs.flutter.dev/ai/mcp-server)  
> **Status:** Experimental (Dart 3.9+ talab qilinadi)

---

## MCP nima?

**MCP (Model Context Protocol)** — Anthropic tomonidan yaratilgan ochiq standart protokol. U AI assistantlar (Cursor, Claude Code, Windsurf va h.k.) bilan development toollar o'rtasida ko'prik vazifasini bajaradi.

MCP'dan oldin AI faqat kod taklif qila olardi. MCP bilan endi AI agent:
- Terminal commandlarni ishlatadi
- Fayllarni o'qiydi va o'zgartiradi
- Ishlab turgan Flutter appni inspect qiladi
- pub.dev dan package qidiradi
- Testlarni ishlatadi va natijani tahlil qiladi

Bularni **mustaqil** bajaradi — siz maqsadni aytasiz, agent bajaradi.

---

## Dart & Flutter MCP Server nima qila oladi?

27 ta tool mavjud. Asosiylar:

### Kod tahlili va xatolarni tuzatish
- Dart analyzer ishlatib barcha xato va warninglarni topadi
- Xatolarni avtomatik fix qiladi
- Symbollarni (class, method, variable) tekshiradi — mavjudligini, doc va signatureni oladi

### Ishlab turgan app bilan ishlash
- Running Flutter appning **widget tree**sini o'qiydi
- **Runtime error**larni (masalan, RenderFlex overflow) real-time ushlab, fix qiladi
- App holati va render tree'ni inspect qiladi

### Package boshqaruvi
- **pub.dev** dan kerakli packageni qidiradi (rating va popularityga qarab)
- `pubspec.yaml` ga dependency **o'zi qo'shadi**
- Boilerplate kodni **o'zi yozadi**

### Test va format
- Testlarni ishlatadi va natijani tahlil qiladi
- `dart format` bilan bir xil qoidalar asosida formatlaydi

---

## O'rnatish

**Talab:** Dart 3.9 yoki undan yuqori

```bash
dart --version
```

---

### Cursor uchun

**Global** (barcha proyektlar uchun) — `~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "dart": {
      "command": "dart",
      "args": ["mcp-server"]
    }
  }
}
```

**Lokal** (faqat shu proyekt uchun) — proyekt root'ida `.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "dart": {
      "command": "dart",
      "args": ["mcp-server"]
    }
  }
}
```

Saqlagach, **Cursor'ni restart** qiling. Settings → Tools & MCPs da `dart — 27 tools enabled` ko'rinishi kerak.

---

### VS Code + GitHub Copilot uchun

Dart extension v3.116+ bo'lishi shart.

`settings.json` ga qo'shing:

```json
"dart.mcpServer": true
```

---

### Claude Code uchun

```bash
claude mcp add --transport stdio dart -- dart mcp-server
```

---

### Windsurf uchun

`.codeium/windsurf/mcp_config.json`:

```json
{
  "mcpServers": {
    "dart-mcp-server": {
      "command": "dart",
      "args": ["mcp-server"]
    }
  }
}
```

---

### Gemini CLI uchun

`~/.gemini/settings.json`:

```json
{
  "mcpServers": {
    "dart": {
      "command": "dart",
      "args": ["mcp-server"]
    }
  }
}
```

---

## Qanday ishlatiladi?

MCP o'rnatilgach, Agent mode'da natural language bilan buyruq berasiz. AI qaysi tool'ni ishlatishni o'zi hal qiladi.

---

### Misol 1 — Barcha analyzer xatolarini tuzatish

```
Analyze my project and fix all dart errors
```

AI orqasida nima qiladi:
1. `flutter analyze` ishlatadi
2. Barcha xatolarni yig'adi
3. Tegishli fayllarni o'zgartiradi
4. Qayta analyze qilib tekshiradi

---

### Misol 2 — Runtime layout xatosi (RenderFlex overflow)

App ishlab turgan paytda:

```
Check for and fix static and runtime analysis issues.
Check for and fix any layout issues.
```

AI nima qiladi:
1. Running app'dan runtime error'larni oladi
2. Widget tree'ni ko'rib, overflow sababini topadi
3. Fix qo'yadi
4. Qayta tekshiradi

---

### Misol 3 — Package qidirish va ulash

```
Find a suitable package to add a line chart that
maps the number of button presses over time.
```

AI nima qiladi:
1. `pub_dev_search` orqali pub.dev da qidiradi
2. Eng yaxshisini taklif qiladi (masalan, `fl_chart`)
3. Tasdiqlasangiz, `pubspec.yaml` ga qo'shadi
4. Boilerplate widget kodni yozadi
5. Syntax xatolarini o'zi tuzatadi

---

### Misol 4 — Testlarni ishlatish

```
Run all tests and show me which ones are failing
```

---

### Misol 5 — Kod formatlash

```
Format all dart files in the lib folder
```

---

## Foydali prompt'lar

```
Analyze my project and fix all dart errors
```
```
Check for and fix any layout issues in the running app
```
```
Find the best package for local push notifications and add it
```
```
Run tests and fix the failing ones
```
```
Format all files and fix lint warnings
```
```
Add [package_name] and write a basic usage example
```

---

## Muhim eslatmalar

**Sandbox permission** — Cursor ba'zan `flutter analyze` yoki boshqa command ishlatishdan oldin ruxsat so'raydi. **Allow** bosing.

**App ishlab turishi kerak** — Widget tree va runtime error'lar bilan ishlash uchun app simulator yoki real device'da debug mode'da ishlab turishi shart.

**Experimental** — Rasmiy docs'da experimental deb belgilangan. Asosiy funksiyalar ishlaydi, lekin ba'zi tool'lar o'zgarishi mumkin.

**Roots fallback** — Agar MCP client roots'ni to'g'ri set qilmasa, `--force-roots-fallback` flag qo'shing:

```json
{
  "mcpServers": {
    "dart": {
      "command": "dart",
      "args": ["mcp-server", "--force-roots-fallback"]
    }
  }
}
```

---

## Manbalar

- Rasmiy docs: [docs.flutter.dev/ai/mcp-server](https://docs.flutter.dev/ai/mcp-server)
- Issue tracker: [github.com/dart-lang/ai/issues](https://github.com/dart-lang/ai/issues)