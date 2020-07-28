#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension NSAttributedString.Key {
    /// `UIFontDescriptor.SymbolicTraits` to use for the given range. Prefer this over customizing the font so sizes
    /// and font traits can cascade.
    public static let fontTraits = NSAttributedString.Key("FontTraits")

    /// Customize the color of the `thematicBreak` line. The value should be a `UIColor`.
    public static let thematicBreakColor = NSAttributedString.Key("ThematicBreakColor")

    /// Customize the thickness of the `thematicBreak` line. The value should be a `CGFloat`.
    public static let thematicBreakThickness = NSAttributedString.Key("ThematicBreakThickness")
}
