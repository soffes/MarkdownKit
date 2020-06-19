import UIKit

extension NSAttributedString.Key {
    /// `UIFontDescriptor.SymbolicTraits` to use for the given range. Prefer this over customizing the font so sizes
    /// and font traits can cascade.
    public static let fontTraits = NSAttributedString.Key("FontTraits")

    /// Apply this to the range of a `thematicBreak` node to have the layout manager draw the rest of the horizontal
    /// rule.
    ///
    /// By default it will use `foregroundColor`. Use `thematicBreakColor` to customize the color of the line.  The
    /// value should be a `Bool`.
    public static let thematicBreak = NSAttributedString.Key("ThematicBreak")

    /// Customize the color of the `thematicBreak` line. The value should be a `UIColor`.
    public static let thematicBreakColor = NSAttributedString.Key("ThematicBreakColor")

    /// Customize the thickness of the `thematicBreak` line. The value should be a `CGFloat`.
    public static let thematicBreakThickness = NSAttributedString.Key("ThematicBreakThickness")
}
