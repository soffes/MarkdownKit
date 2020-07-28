#if os(macOS)
import AppKit
#else
import UIKit
#endif

public struct Style {
    public var range: NSRange
    public var attributes: [NSAttributedString.Key: Any]

    public init(range: NSRange, attributes: [NSAttributedString.Key: Any]) {
        self.range = range
        self.attributes = attributes
    }
}
