# MDLook Audit

Audit date: 2026-05-24

## Upstream Import

The working directory was empty and not a git repository. I imported
`https://github.com/smittytone/PreviewMarkdown.git` as the base project.

## Targets And Schemes

Xcode project: `PreviewMarkdown.xcodeproj`

Targets found in the project:

- `PreviewMarkdown`: host macOS app target. In this fork it builds product `MDLook.app`.
- `Markdown Previewer`: Quick Look preview extension.
- `Markdown Thumbnailer`: Quick Look thumbnail extension.
- `PreviewMarkdownTests`: upstream test target.
- `RenderDemo`: upstream render demo target.

Shared schemes after fork setup:

- `MDLook`
- `Previewer`
- `Thumbnailer`
- `RenderDemo`

## Bundle Identifiers

Fork bundle identifiers are configured as:

- Host app: `me.rsy42.mdlook`
- Preview extension: `me.rsy42.mdlook.preview`
- Thumbnail extension: `me.rsy42.mdlook.thumbnail`
- Tests: `me.rsy42.mdlook.tests`
- RenderDemo: `me.rsy42.mdlook.renderdemo`

## Missing Files In Upstream Checkout

The upstream README says the repository only includes primary source code. The
checkout referenced missing local/private files:

- `REPLACE_WITH_YOUR_FUNCTIONS.swift`
- `REPLACE_WITH_YOUR_CODES.swift`
- Host app `Assets.xcassets`
- Previewer `Assets.xcassets`
- `new/new.html`
- `AppIcon.icon` from an absolute local iCloud path

Fork replacements:

- `PreviewMarkdown/FeedbackStub.swift`
- `PreviewMarkdown/MDLookConfig.swift`
- `PreviewMarkdown/Assets.xcassets`
- `Markdown Previewer/Assets.xcassets`
- `PreviewMarkdown/new/new.html`

The missing `AppIcon.icon` resource was removed from the build resources in
favor of the generated `Assets.xcassets` app icon.

## Team ID And App Group

Upstream hard-coded `Y5J3K52DNA` as `DEVELOPMENT_TEAM[sdk=macosx*]` in several
build configurations. This fork clears those settings to:

```text
DEVELOPMENT_TEAM = "";
DEVELOPMENT_TEAM[sdk=macosx*] = "";
```

App Group / suite placeholder:

```text
TEAMID_PLACEHOLDER.me.rsy42.mdlook
```

Files involved:

- `PreviewMarkdown/MDLookConfig.swift`
- `PreviewMarkdown/PreviewMarkdown.entitlements`
- `Markdown Previewer/Previewer.entitlements`
- `Markdown Thumbnailer/Thumbnailer.entitlements`
- `RenderDemo/RenderDemo.entitlements`

Before a signed build, replace `TEAMID_PLACEHOLDER` with your Apple Developer
Team ID in those files and configure the same App Group in your Apple Developer
account if needed.

## Quick Look Configuration

Preview extension:

- Extension point: `com.apple.quicklook.preview`
- Principal class: `$(PRODUCT_MODULE_NAME).PreviewViewController`
- Supported types include `public.markdown`, `net.daringfireball.markdown`,
  `net.multimarkdown.text`, and several app-specific Markdown UTIs.

Thumbnail extension:

- Extension point: `com.apple.quicklook.thumbnail`
- Principal class: `$(PRODUCT_MODULE_NAME).ThumbnailProvider`
- Supported types mirror the preview extension.
- Minimum thumbnail dimension: `32`

## Original Branding, Store Links, And Feedback

Areas involving original upstream branding or links:

- `PreviewMarkdown/Base.lproj/MainMenu.xib`
- `PreviewMarkdown/Constants.swift`
- `PreviewMarkdown/Info.plist`
- Extension `licences.txt` files
- `CHANGELOG.md`
- `LICENSE.md`

Fork cleanup performed:

- Visible app name changed to `MDLook`.
- App Store URLs were replaced with the upstream GitHub URL to avoid pointing
  fork users at the original author's App Store listing.
- Remote feedback submission was disabled in `PreviewMarkdown/FeedbackStub.swift`
  and `PreviewMarkdown/AppDelegateFeedback.swift`.
- Upstream MIT license and third-party license references were retained.

Remaining upstream references are intentional attribution or source history.

## Minimal Build Path

1. Open `PreviewMarkdown.xcodeproj` in Xcode.
2. Select the `MDLook` scheme.
3. For compile-only validation, build with code signing disabled.
4. For a real local Quick Look build, replace the Team ID placeholder, set the
   Signing Team for the host app and both extensions, then build and run the
   host app once.

Command-line compile-only path:

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
