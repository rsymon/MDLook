#!/bin/sh
set -u

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PROJECT="$ROOT_DIR/PreviewMarkdown.xcodeproj"

failures=0

check() {
  label="$1"
  shift
  if "$@" >/dev/null 2>&1; then
    printf "ok   %s\n" "$label"
  else
    printf "fail %s\n" "$label"
    failures=$((failures + 1))
  fi
}

warn_if_grep() {
  label="$1"
  pattern="$2"
  shift 2
  if grep -R "$pattern" "$@" >/dev/null 2>&1; then
    printf "warn %s\n" "$label"
  else
    printf "ok   %s\n" "$label"
  fi
}

check "running on macOS" test "$(uname -s)" = "Darwin"
check "xcodebuild available" command -v xcodebuild
check "project exists" test -d "$PROJECT"
check "MDLook scheme exists" test -f "$PROJECT/xcshareddata/xcschemes/MDLook.xcscheme"
check "host app icon asset exists" test -f "$ROOT_DIR/PreviewMarkdown/Assets.xcassets/AppIcon.appiconset/Contents.json"
check "preview assets exist" test -f "$ROOT_DIR/Markdown Previewer/Assets.xcassets/missing-img.imageset/Contents.json"
check "new.html exists" test -f "$ROOT_DIR/PreviewMarkdown/new/new.html"
check "local config exists" test -f "$ROOT_DIR/PreviewMarkdown/MDLookConfig.swift"
check "feedback stub exists" test -f "$ROOT_DIR/PreviewMarkdown/FeedbackStub.swift"

warn_if_grep "Team ID placeholder still present" "TEAMID_PLACEHOLDER" \
  "$ROOT_DIR/PreviewMarkdown/MDLookConfig.swift" \
  "$ROOT_DIR/PreviewMarkdown/PreviewMarkdown.entitlements" \
  "$ROOT_DIR/Markdown Previewer/Previewer.entitlements" \
  "$ROOT_DIR/Markdown Thumbnailer/Thumbnailer.entitlements" \
  "$ROOT_DIR/RenderDemo/RenderDemo.entitlements"

warn_if_grep "DEVELOPMENT_TEAM is still blank" "DEVELOPMENT_TEAM = \"\";" \
  "$ROOT_DIR/PreviewMarkdown.xcodeproj/project.pbxproj"

if [ "$failures" -gt 0 ]; then
  printf "\n%d required check(s) failed.\n" "$failures"
  exit 1
fi

printf "\nDoctor finished. Warnings are expected before you set your own signing team.\n"
