#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// Theme with some default UIKit colors
open class DefaultTheme: Theme {

    // MARK: - Properties

    open var secondaryForegroundColor: Color {
        #if os(macOS)
        return NSColor.secondaryLabelColor
        #else
        return UIColor.secondaryLabel
        #endif
    }

    open var linkColor: Color {
        #if os(macOS)
        return NSColor.linkColor
        #else
        return UIColor.link
        #endif
    }

    open var delimiterColor: Color {
        foregroundColor.withAlphaComponent(0.5)
    }

    // MARK: - Theme

    open override var font: Font {
        #if os(macOS)
        return NSFont.monospacedSystemFont(ofSize: NSFont.systemFontSize, weight: .regular)
        #else
        return UIFont.monospacedSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize,
                                           weight: .regular)
        #endif
    }

    open override var baseAttributes: [NSAttributedString.Key: Any] {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineHeightMultiple = 1.25

        return [
            .font: font,
            .foregroundColor: foregroundColor,
            .paragraphStyle: paragraph
        ]
    }

    open override func blockquote(_ node: Node, range: NSRange) -> [Style] {
        [Style(range: range, attributes: [.foregroundColor: secondaryForegroundColor])] + delimiterStyles(for: node)
    }

    open override func codeBlock(_ node: Node, range: NSRange) -> [Style] {
        [Style(range: range, attributes: [.foregroundColor: secondaryForegroundColor])]
    }

    open override func htmlBlock(_ node: Node, range: NSRange) -> [Style] {
        [Style(range: range, attributes: [.foregroundColor: secondaryForegroundColor])]
    }

    open override func heading(_ node: Heading, range: NSRange) -> [Style] {
        let attributes: [NSAttributedString.Key: Any]
        switch node.level {
        case .one:
            attributes = [
                .fontTraits: FontSymbolicTraits.traitBold,
                .foregroundColor: foregroundColor
            ]

        case .two:
            attributes = [
                .fontTraits: FontSymbolicTraits.traitBold
            ]

        case .three:
            attributes = [
                .fontTraits: FontSymbolicTraits.traitBold,
                .foregroundColor: secondaryForegroundColor
            ]

        case .four:
            attributes = [
                .fontTraits: FontSymbolicTraits.traitBold,
                .foregroundColor: secondaryForegroundColor
            ]

        case .five:
            attributes = [
                .foregroundColor: secondaryForegroundColor
            ]

        case .six:
            attributes = [
                .foregroundColor: secondaryForegroundColor
            ]
        }

        return [Style(range: range, attributes: attributes)] + delimiterStyles(for: node)
    }

    open override func item(_ node: ListItem, range: NSRange) -> [Style] {
        delimiterStyles(for: node)
    }

    open override func thematicBreak(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [
                .thematicBreakColor: foregroundColor.withAlphaComponent(0.2)
            ])
        ] + delimiterStyles(for: node)
    }

    open override func codeInline(_ node: Node, range: NSRange) -> [Style] {
        [Style(range: range, attributes: [.foregroundColor: secondaryForegroundColor])] + delimiterStyles(for: node)
    }

    open override func htmlInline(_ node: Node, range: NSRange) -> [Style] {
        [Style(range: range, attributes: [.foregroundColor: secondaryForegroundColor])]
    }

    open override func emphasis(_ node: Node, range: NSRange) -> [Style] {
        [Style(range: range, attributes: [.fontTraits: FontSymbolicTraits.traitItalic])]
            + delimiterStyles(for: node)
    }

    open override func strong(_ node: Node, range: NSRange) -> [Style] {
        [Style(range: range, attributes: [.fontTraits: FontSymbolicTraits.traitBold])]
            + delimiterStyles(for: node)
    }

    open override func link(_ node: Link, range: NSRange) -> [Style] {
        [Style(range: range, attributes: [.foregroundColor: linkColor])]
            + delimiterStyles(for: node, attributes: [.foregroundColor: linkColor.withAlphaComponent(0.5)])
            + urlStyles(for: node)
    }

    open override func image(_ node: Image, range: NSRange) -> [Style] {
        [Style(range: range, attributes: [.foregroundColor: linkColor])]
            + delimiterStyles(for: node, attributes: [.foregroundColor: linkColor.withAlphaComponent(0.5)])
            + urlStyles(for: node)
    }

    open override func strikethrough(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.foregroundColor: secondaryForegroundColor]),
            Style(range: node.firstChild!.range!, attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                .strikethroughColor: foregroundColor
            ])
        ] + delimiterStyles(for: node)
    }

    // MARK: - Initializers

    public override init() {
        super.init()
    }

    // MARK: - Utilities

    func delimiterStyles(for node: Node, attributes: [NSAttributedString.Key: Any]? = nil) -> [Style] {
        guard let ranges = node.delimiters else {
            return []
        }

        let attributes = attributes ?? [.foregroundColor: delimiterColor]

        return ranges.map { range in
            Style(range: range, attributes: attributes)
        }
    }

    func urlStyles(for node: Link,
                   attributes: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue])
        -> [Style]
    {
        guard let urlRange = node.urlRange else {
            return []
        }

        return [Style(range: urlRange, attributes: attributes)]
    }
}
