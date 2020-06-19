import UIKit

public final class LayoutManager: NSLayoutManager {
    public override func drawBackground(forGlyphRange range: NSRange, at origin: CGPoint) {
        super.drawBackground(forGlyphRange: range, at: origin)

        guard let textStorage = textStorage else {
            return
        }

        // Draw thematic break decorations
        textStorage.enumerateAttribute(.thematicBreak, in: range, options: [.longestEffectiveRangeNotRequired])
        { value, range, _ in
            guard (value as? Bool) == true, let context = UIGraphicsGetCurrentContext() else {
                return
            }

            let attributes = textStorage.attributes(at: range.location, effectiveRange: nil)

            guard let font = attributes[.font] as? UIFont else {
                return
            }

            let color = attributes[.thematicBreakColor] as? UIColor ?? attributes[.foregroundColor] as? UIColor
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
}
