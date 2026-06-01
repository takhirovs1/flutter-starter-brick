#!/usr/bin/env bash
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; NC='\033[0m'

BRICK_REPO="https://github.com/udevs/flutter-starter-brick"
BRICK_REF="v1.0.0"
BRICK_NAME="core_app"
FLUTTER_VERSION="3.41.6"
ORG_DEFAULT="io.udevs"

info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[✅]${NC} $1"; }
warn()    { echo -e "${YELLOW}[⚠️]${NC} $1"; }
fail()    { echo -e "${RED}[❌]${NC} $1"; }
step()    { echo -e "\n${CYAN}━━━ $1 ━━━${NC}"; }
command_exists() { command -v "$1" >/dev/null 2>&1; }

detect_os() {
  case "$(uname -s)" in
    Darwin*) OS="macos" ;; Linux*) OS="linux" ;; MINGW*|MSYS*|CYGWIN*) OS="windows" ;; *) OS="unknown" ;;
  esac
  info "OS detected: $OS"
}

install_brew() {
  [ "$OS" != "macos" ] && return
  if command_exists brew; then success "Homebrew installed"; return; fi
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  [ -f "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"
  success "Homebrew installed"
}

install_git() {
  if command_exists git; then success "Git installed"; return; fi
  info "Installing Git..."
  case "$OS" in
    macos) brew install git ;; linux) sudo apt-get update && sudo apt-get install -y git ;;
    windows) winget install --id Git.Git -e --source winget 2>/dev/null || warn "Install Git manually: https://git-scm.com" ;;
  esac
}

install_xcode_cli() {
  [ "$OS" != "macos" ] && return
  if xcode-select -p >/dev/null 2>&1; then success "Xcode CLI Tools installed"; return; fi
  info "Installing Xcode Command Line Tools..."
  xcode-select --install 2>/dev/null || true
  warn "Install dialog opened. Press ENTER when done."
  read -rp ""
}

install_android_studio() {
  [ "$OS" != "macos" ] && return
  if [ -d "/Applications/Android Studio.app" ]; then success "Android Studio installed"; return; fi
  read -rp "Install Android Studio? (y/n): " ans
  [[ "$ans" =~ ^[Yy]$ ]] && brew install --cask android-studio && success "Android Studio installed" || warn "Skipped. Install later from https://developer.android.com/studio"
}

install_fvm() {
  if command_exists fvm; then success "FVM installed"; return; fi
  info "Installing FVM..."
  case "$OS" in
    macos) brew tap leoafarias/fvm && brew install fvm ;;
    *) dart pub global activate fvm 2>/dev/null || warn "FVM installation failed" ;;
  esac
}

install_flutter() {
  if fvm list 2>/dev/null | grep -q "$FLUTTER_VERSION"; then
    success "Flutter $FLUTTER_VERSION available (FVM)"
  else
    info "Installing Flutter $FLUTTER_VERSION via FVM..."
    fvm install "$FLUTTER_VERSION" || { fail "Flutter installation failed"; exit 1; }
    success "Flutter $FLUTTER_VERSION installed"
  fi
  fvm global "$FLUTTER_VERSION" 2>/dev/null || true
  export PATH="$HOME/fvm/default/bin:$HOME/.pub-cache/bin:$PATH"
  command_exists flutter && success "Flutter ready on PATH" || warn "Use 'fvm flutter' instead"
}

install_cocoapods() {
  [ "$OS" != "macos" ] && return
  if command_exists pod; then success "CocoaPods installed"; return; fi
  info "Installing CocoaPods..."
  brew install cocoapods
  success "CocoaPods installed"
}

install_mason() {
  export PATH="$HOME/.pub-cache/bin:$PATH"
  if command_exists mason; then success "Mason CLI installed"; return; fi
  info "Installing Mason CLI..."
  dart pub global activate mason_cli 2>/dev/null || fvm dart pub global activate mason_cli 2>/dev/null || { fail "Mason installation failed"; exit 1; }
  success "Mason CLI installed"
}

ask_project_details() {
  step "PROJECT DETAILS"
  while true; do
    read -rp "$(echo -e "${CYAN}Project name${NC} (snake_case, e.g. shop_app): ")" PROJECT_NAME
    PROJECT_NAME="$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr -c 'a-z0-9' '_' | sed 's/__*/_/g; s/^_//; s/_$//')"
    [ -n "$PROJECT_NAME" ] && break
    fail "Name cannot be empty"
  done
  read -rp "$(echo -e "${CYAN}Package name${NC} [$ORG_DEFAULT.$PROJECT_NAME]: ")" APP_ID
  APP_ID="${APP_ID:-$ORG_DEFAULT.$PROJECT_NAME}"
  local last="${APP_ID##*.}"
  local ios_bundle="${APP_ID%.*}.$(echo "$last" | sed -E 's/_([a-z])/\U\1/g')"
  echo ""
  echo -e "  ${GREEN}Project:${NC}          $PROJECT_NAME"
  echo -e "  ${GREEN}Android package:${NC}  $APP_ID"
  echo -e "  ${GREEN}iOS bundle ID:${NC}    $ios_bundle"
  echo ""
  read -rp "Correct? (y/n): " ok
  [[ "$ok" =~ ^[Yy]$ ]] || { ask_project_details; return; }
}

create_project() {
  step "CREATING PROJECT"
  export PATH="$HOME/.pub-cache/bin:$PATH"
  info "Registering brick ($BRICK_REF)..."
  mason add -g "$BRICK_NAME" --git-url "$BRICK_REPO" --git-ref "$BRICK_REF" --force >/dev/null 2>&1 || {
    fail "Brick registration failed. Check repo access: $BRICK_REPO"; exit 1
  }
  [ -e "$PROJECT_NAME" ] && { fail "'$PROJECT_NAME' already exists. Choose another name."; exit 1; }
  info "Generating project..."
  mason make "$BRICK_NAME" -o . --on-conflict overwrite --project_name "$PROJECT_NAME" --application_id "$APP_ID"
  success "Project created: ./$PROJECT_NAME"
}

finalize() {
  step "DONE"
  cd "$PROJECT_NAME" 2>/dev/null || true
  command_exists fvm && [ -f ".fvmrc" ] && fvm use "$FLUTTER_VERSION" --force 2>/dev/null || true
  echo ""
  echo -e "  ${GREEN}Project ready at:${NC} $(pwd)"
  echo ""
  echo -e "  ${CYAN}Run:${NC}    cd $PROJECT_NAME && flutter run"
  echo -e "  ${CYAN}Open:${NC}   cursor .  OR  code ."
  echo ""
}

main() {
  echo ""
  echo -e "${CYAN}╔══════════════════════════════════════════════╗${NC}"
  echo -e "${CYAN}║   Udevs Flutter Project Bootstrap v2.0      ║${NC}"
  echo -e "${CYAN}╚══════════════════════════════════════════════╝${NC}"
  echo ""
  detect_os
  step "CHECKING TOOLS"
  [ "$OS" = "macos" ] && install_brew
  install_git
  [ "$OS" = "macos" ] && install_xcode_cli
  install_android_studio
  install_fvm
  install_flutter
  [ "$OS" = "macos" ] && install_cocoapods
  install_mason
  success "All tools ready!"
  ask_project_details
  create_project
  finalize
}

main "$@"
