#if os(macOS)
import AppKit
public typealias Font = NSFont
public typealias FontSymbolicTraits = NSFontDescriptor.SymbolicTraits

extension FontSymbolicTraits {
    static var traitItalic: NSFontDescriptor.SymbolicTraits {
        .italic
    }

    static var traitBold: NSFontDescriptor.SymbolicTraits {
        .bold
    }
}
#else
import UIKit
public typealias Font = UIFont
public typealias FontSymbolicTraits = UIFontDescriptor.SymbolicTraits
#endif
