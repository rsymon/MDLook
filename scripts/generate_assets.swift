import AppKit

let root = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let iconDir = root.appendingPathComponent("PreviewMarkdown/Assets.xcassets/AppIcon.appiconset")
let previewAssets = root.appendingPathComponent("Markdown Previewer/Assets.xcassets")

func writePNG(_ image: NSImage, to url: URL) throws {
    guard
        let tiff = image.tiffRepresentation,
        let bitmap = NSBitmapImageRep(data: tiff),
        let data = bitmap.representation(using: .png, properties: [:])
    else {
        throw NSError(domain: "MDLookAssets", code: 1)
    }

    try data.write(to: url)
}

func drawIcon(size: CGFloat) -> NSImage {
    let image = NSImage(size: NSSize(width: size, height: size))
    image.lockFocus()

    let rect = NSRect(x: 0, y: 0, width: size, height: size)
    NSColor(calibratedRed: 0.08, green: 0.11, blue: 0.16, alpha: 1).setFill()
    NSBezierPath(roundedRect: rect, xRadius: size * 0.2, yRadius: size * 0.2).fill()

    NSColor(calibratedRed: 0.18, green: 0.68, blue: 0.72, alpha: 1).setFill()
    let folded = NSBezierPath()
    folded.move(to: NSPoint(x: size * 0.66, y: size * 0.82))
    folded.line(to: NSPoint(x: size * 0.82, y: size * 0.66))
    folded.line(to: NSPoint(x: size * 0.66, y: size * 0.66))
    folded.close()
    folded.fill()

    let page = NSBezierPath(roundedRect: NSRect(x: size * 0.2, y: size * 0.14, width: size * 0.62, height: size * 0.72),
                            xRadius: size * 0.05,
                            yRadius: size * 0.05)
    NSColor(calibratedWhite: 0.96, alpha: 1).setFill()
    page.fill()

    let paragraph = NSBezierPath()
    paragraph.move(to: NSPoint(x: size * 0.32, y: size * 0.56))
    paragraph.line(to: NSPoint(x: size * 0.45, y: size * 0.40))
    paragraph.line(to: NSPoint(x: size * 0.56, y: size * 0.56))
    paragraph.line(to: NSPoint(x: size * 0.64, y: size * 0.40))
    paragraph.lineWidth = max(2, size * 0.045)
    paragraph.lineCapStyle = .round
    paragraph.lineJoinStyle = .round
    NSColor(calibratedRed: 0.08, green: 0.11, blue: 0.16, alpha: 1).setStroke()
    paragraph.stroke()

    image.unlockFocus()
    return image
}

func drawPlaceholder(size: CGFloat, locked: Bool) -> NSImage {
    let image = NSImage(size: NSSize(width: size, height: size))
    image.lockFocus()

    let rect = NSRect(x: 0, y: 0, width: size, height: size)
    NSColor(calibratedWhite: 0.18, alpha: 1).setFill()
    NSBezierPath(roundedRect: rect, xRadius: size * 0.12, yRadius: size * 0.12).fill()

    NSColor(calibratedRed: 0.18, green: 0.68, blue: 0.72, alpha: 1).setStroke()
    let symbol = NSBezierPath()
    symbol.lineWidth = size * 0.08
    symbol.lineCapStyle = .round
    symbol.lineJoinStyle = .round

    if locked {
        let body = NSBezierPath(roundedRect: NSRect(x: size * 0.28, y: size * 0.24, width: size * 0.44, height: size * 0.34),
                                xRadius: size * 0.05,
                                yRadius: size * 0.05)
        body.lineWidth = size * 0.07
        body.stroke()
        let shackle = NSBezierPath()
        shackle.lineWidth = size * 0.07
        shackle.appendArc(withCenter: NSPoint(x: size * 0.5, y: size * 0.58),
                          radius: size * 0.18,
                          startAngle: 0,
                          endAngle: 180)
        shackle.stroke()
    } else {
        symbol.move(to: NSPoint(x: size * 0.28, y: size * 0.30))
        symbol.line(to: NSPoint(x: size * 0.44, y: size * 0.52))
        symbol.line(to: NSPoint(x: size * 0.56, y: size * 0.40))
        symbol.line(to: NSPoint(x: size * 0.74, y: size * 0.66))
        symbol.stroke()
    }

    image.unlockFocus()
    return image
}

for size in [16, 32, 64, 128, 256, 512, 1024] {
    try writePNG(drawIcon(size: CGFloat(size)), to: iconDir.appendingPathComponent("mdlook_\(size).png"))
}

try writePNG(drawPlaceholder(size: 100, locked: false), to: previewAssets.appendingPathComponent("missing-img.imageset/missing-img.png"))
try writePNG(drawPlaceholder(size: 200, locked: false), to: previewAssets.appendingPathComponent("missing-img.imageset/missing-img@2x.png"))
try writePNG(drawPlaceholder(size: 100, locked: true), to: previewAssets.appendingPathComponent("locked-img.imageset/locked-img.png"))
try writePNG(drawPlaceholder(size: 200, locked: true), to: previewAssets.appendingPathComponent("locked-img.imageset/locked-img@2x.png"))
