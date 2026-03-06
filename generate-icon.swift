#!/usr/bin/env swift

import AppKit

let sizes = [16, 32, 64, 128, 256, 512, 1024]
let iconsetPath = "/tmp/ShiftRepeater.iconset"

// Create iconset directory
let fm = FileManager.default
try? fm.removeItem(atPath: iconsetPath)
try fm.createDirectory(atPath: iconsetPath, withIntermediateDirectories: true)

for size in sizes {
    let s = CGFloat(size)
    let image = NSImage(size: NSSize(width: s, height: s))
    image.lockFocus()

    let ctx = NSGraphicsContext.current!.cgContext

    // Background: rounded rect dark gray
    let cornerRadius = s * 0.2
    let bgRect = CGRect(x: 0, y: 0, width: s, height: s)
    let bgPath = CGPath(roundedRect: bgRect, cornerWidth: cornerRadius, cornerHeight: cornerRadius, transform: nil)
    ctx.setFillColor(NSColor(red: 0.18, green: 0.18, blue: 0.2, alpha: 1.0).cgColor)
    ctx.addPath(bgPath)
    ctx.fillPath()

    // Draw ⇧ symbol
    let fontSize = s * 0.55
    let attrs: [NSAttributedString.Key: Any] = [
        .font: NSFont.systemFont(ofSize: fontSize, weight: .semibold),
        .foregroundColor: NSColor.white
    ]
    let str = NSAttributedString(string: "⇧", attributes: attrs)
    let strSize = str.size()
    let strPoint = NSPoint(
        x: (s - strSize.width) / 2,
        y: (s - strSize.height) / 2
    )
    str.draw(at: strPoint)

    image.unlockFocus()

    // Save as PNG
    guard let tiff = image.tiffRepresentation,
          let rep = NSBitmapImageRep(data: tiff),
          let png = rep.representation(using: .png, properties: [:]) else {
        continue
    }

    let filename: String
    if size <= 512 {
        // 1x
        try png.write(to: URL(fileURLWithPath: "\(iconsetPath)/icon_\(size)x\(size).png"))
        // 2x (half the stated size)
        let half = size / 2
        if half >= 16 {
            // copy as @2x of the smaller size
            try png.write(to: URL(fileURLWithPath: "\(iconsetPath)/icon_\(half)x\(half)@2x.png"))
        }
    }
    if size == 1024 {
        try png.write(to: URL(fileURLWithPath: "\(iconsetPath)/icon_512x512@2x.png"))
    }
}

print("Iconset created at \(iconsetPath)")
