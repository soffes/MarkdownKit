#if os(macOS)
import AppKit
#else
import UIKit
#endif

public final class LayoutManager: NSLayoutManager {

    // MARK: - NSLayoutManager

    public override func drawBackground(forGlyphRange range: NSRange, at origin: CGPoint) {
        super.drawBackground(forGlyphRange: range, at: origin)

        guard let textStorage = textStorage as? TextStorage, let document = textStorage.document else {
            return
        }

        // Draw thematic break decorations
        for block in document.children {
            guard block.kind == .thematicBreak, let range = block.range else {
                continue
            }

            drawThematicBreak(range: range, at: origin)
        }
    }

    // MARK: - Private

    private func drawThematicBreak(range: NSRange, at origin: CGPoint) {
        #if os(macOS)
        guard let textStorage = textStorage, let context = NSGraphicsContext.current?.cgContext else {
            return
        }
        #else
        guard let textStorage = textStorage, let context = UIGraphicsGetCurrentContext() else {
            return
        }
        #endif

        let attributes = textStorage.attributes(at: range.location, effectiveRange: nil)

        guard let font = attributes[.font] as? Font else {
            return
        }

        let color = attributes[.thematicBreakColor] as? Color ?? attributes[.foregroundColor] as? Color
            ?? .black

        // Find the remainder of the line
        let spacing: CGFloat = 4
        let used = lineFragmentUsedRect(forGlyphAt: range.location, effectiveRange: nil)
        var rect = lineFragmentRect(forGlyphAt: range.location, effectiveRange: nil)
        rect.size.width -= used.width + spacing
        rect.origin.x = used.maxX + spacing

        // Apply the line thickness
        let thickness = attributes[.thematicBreakThickness] as? CGFloat ?? 1
        rect.origin.y += rect.size.height - font.xHeight - floor(thickness / 2)
        rect.size.height = thickness

        // Offset for the layout manager’s origin
        rect.origin.x += origin.x
        rect.origin.y += origin.y

        // Draw
        context.saveGState()
        context.setFillColor(color.cgColor)
        context.fill(rect)
        context.restoreGState()
    }
}
