#if os(macOS)
import AppKit
#else
import UIKit
#endif

import MarkdownKitObjC

public protocol TextStorageCustomDelegate: AnyObject {
    func textStorage(_ textStorage: TextStorage, didParseDocument document: Document)
    func textStorage(_ textStorage: TextStorage, didChangeTheme theme: Theme)

    func textStorage(_ textStorage: TextStorage, shouldChangeTextIn range: NSRange, with string: String,
                     actionName: String) -> Bool
    func textStorage(_ textStorage: TextStorage, didUpdateSelectedRange range: NSRange)
}

public final class TextStorage: BaseTextStorage {

    // MARK: - Properties

    public weak var customDelegate: TextStorageCustomDelegate?

    public private(set) var document: Document?

    public var theme = DefaultTheme() {
        didSet {
            customDelegate?.textStorage(self, didChangeTheme: theme)
            refreshTheme()
        }
    }

    public var typingAttributes: [NSAttributedString.Key: Any] {
        return theme.baseAttributes
    }

    public var bounds: NSRange {
        return NSRange(location: 0, length: string.length)
    }

    private var needsParse = false

    // MARK: - NSTextStorage

    public override func replaceCharacters(in range: NSRange, with string: String) {
        needsParse = true
        super.replaceCharacters(in: range, with: string)
    }

    // MARK: - Parsing

    /// Reparse `string` and updated the attributes based on `theme`.
    ///
    /// This should be called from `textViewDidChange` or in `UITextView.text`’s `didSet`.
    public func parseIfNeeded() {
        guard needsParse else {
            return
        }

        parse()
    }

    /// Throw away the AST, reparse, and update the styles
    func parse() {
        needsParse = false

        beginEditing()
        resetAttributes()

        if let document = Parser.parse(string) {
            self.document = document
        customDelegate?.textStorage(self, didParseDocument: document)
            addAttributes(for: document, currentFont: theme.font)
        } else {
            self.document = nil
        }

        endEditing()
    }

    /// Reapply the theme without reparsing the document.
    ///
    /// This is automatically called after setting the `theme` property. You should only use this if a derived property
    /// in your theme changes. For example, maybe your theme’s font is based on Dynamic Type, you could call this method
    /// when you detect a Dynamic Type change.
    public func refreshTheme() {
        guard let document = document else {
            return
        }

        beginEditing()
        resetAttributes()
        addAttributes(for: document, currentFont: theme.font)
        endEditing()
    }

    // MARK: - Private

    /// Reset all attributes. Down the road, we could detect the maximum affect area and only reset those.
    private func resetAttributes() {
        setAttributes(typingAttributes, range: bounds)
    }

    private func addAttributes(for node: Node, currentFont: Font) {
        var currentFont = currentFont

        if let range = node.range {
            let styles = theme.styles(for: node, range: range)

            for style in styles {
                var attributes = style.attributes
                if let traits = attributes[.fontTraits] as? FontSymbolicTraits {
                    currentFont = currentFont.addingTraits(traits)
                    attributes[.font] = currentFont
                    attributes.removeValue(forKey: .fontTraits)
                }

                addAttributes(attributes, range: style.range)
            }
        }

        for child in node.children {
            addAttributes(for: child, currentFont: currentFont)
        }
    }
}
