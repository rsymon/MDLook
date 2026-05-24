# MDLook

MDLook is a lightweight macOS Markdown Quick Look reader forked from
[smittytone/PreviewMarkdown](https://github.com/smittytone/PreviewMarkdown).

The goal is deliberately small: preview `.md`, `.markdown`, and `.mdown` files
from Finder / Quick Look, and generate Finder thumbnails. MDLook is not a
Markdown editor.

## Status

This fork keeps the upstream source layout and replaces the missing upstream
private files with local placeholders:

- `PreviewMarkdown/MDLookConfig.swift` centralizes the local Team ID placeholder.
- `PreviewMarkdown/FeedbackStub.swift` disables remote feedback submission.
- `PreviewMarkdown/Assets.xcassets` contains a generated temporary app icon.
- `Markdown Previewer/Assets.xcassets` contains generated placeholder assets.
- `PreviewMarkdown/new/new.html` provides the local "What's New" page.

## Build

See [docs/BUILD.md](docs/BUILD.md) for the full local macOS + Xcode workflow.

Quick compile-only check:

```sh
scripts/doctor.sh
xcodebuild -project PreviewMarkdown.xcodeproj \
  -scheme MDLook \
  -configuration Debug \
  -destination 'platform=macOS' \
  -derivedDataPath ./DerivedData \
  -clonedSourcePackagesDirPath ./SourcePackages \
  CODE_SIGNING_ALLOWED=NO \
  build
```

For a signed Quick Look extension build, replace `TEAMID_PLACEHOLDER` with your
Apple Developer Team ID in the files listed in `docs/BUILD.md`, then set the
Signing Team in Xcode.

## License

The upstream PreviewMarkdown source is MIT licensed. This fork keeps
`LICENSE.md` unchanged and adds `NOTICE.md` for fork attribution.

Third-party references from upstream are preserved in the extension
`licences.txt` files.
