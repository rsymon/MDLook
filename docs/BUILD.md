# Building MDLook

## Requirements

- macOS
- Xcode installed from the App Store or Apple Developer downloads
- Command Line Tools selected with `xcode-select`
- Network access for Swift Package dependencies:
  - `https://github.com/smittytone/YamlSwift.git`
  - `https://github.com/smittytone/HighlighterSwift`

## First Check

```sh
scripts/doctor.sh
```

The script checks for macOS, `xcodebuild`, the Xcode project, required local
replacement files, and remaining Team ID placeholders.

## Compile-Only Build

This verifies source compilation without requiring a signing identity:

```sh
xcodebuild -project PreviewMarkdown.xcodeproj \
  -scheme MDLook \
  -configuration Debug \
  -destination 'platform=macOS' \
  -derivedDataPath ./DerivedData \
  -clonedSourcePackagesDirPath ./SourcePackages \
  CODE_SIGNING_ALLOWED=NO \
  build
```

## Signed Local Build

Quick Look extensions need a real signed app to register cleanly with macOS.

1. Open `PreviewMarkdown.xcodeproj` in Xcode.
2. Select the `MDLook` scheme.
3. In Signing & Capabilities, set your Apple Developer Team for:
   - `PreviewMarkdown` host target
   - `Markdown Previewer`
   - `Markdown Thumbnailer`
4. Replace `TEAMID_PLACEHOLDER` with your Apple Developer Team ID in:
   - `PreviewMarkdown/MDLookConfig.swift`
   - `PreviewMarkdown/PreviewMarkdown.entitlements`
   - `Markdown Previewer/Previewer.entitlements`
   - `Markdown Thumbnailer/Thumbnailer.entitlements`
   - `RenderDemo/RenderDemo.entitlements`
5. Keep the app group suffix consistent:
   - `TEAMID_PLACEHOLDER.me.rsy42.mdlook`
6. Build and run the host app once. You can quit after launch.
7. In Finder, select a `.md`, `.markdown`, or `.mdown` file and press Space.

If preview or thumbnail registration is stale:

```sh
qlmanage -r
qlmanage -r cache
killall Finder
```

If the extension still does not appear, open System Settings > Extensions >
Quick Look and make sure the MDLook extensions are enabled. Logging out and
back in can also force Launch Services and Quick Look to refresh.

## Notes

The project keeps the upstream project file name `PreviewMarkdown.xcodeproj` to
minimize churn. The host product is `MDLook.app`, and the shared build scheme is
`MDLook`.
