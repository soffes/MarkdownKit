import UIKit

/// Theme with some default UIKit colors
open class DefaultTheme: Theme {

    // MARK: - Properties

    open var secondaryForegroundColor: UIColor {
        .secondaryLabel
    }

    open var linkColor: UIColor {
        .link
    }

    open var delimiterColor: UIColor {
        foregroundColor.withAlphaComponent(0.5)
    }

    // MARK: - Theme

    open override var font: UIFont {
        return UIFont(name: "Menlo", size: UIFont.preferredFont(forTextStyle: .body).pointSize)!
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
        [
            Style(range: range, attributes: [.foregroundColor: secondaryForegroundColor])
        ]
    }

    open override func codeBlock(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.foregroundColor: secondaryForegroundColor])
        ]
    }

    open override func htmlBlock(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.foregroundColor: secondaryForegroundColor])
        ]
    }

    open override func heading(_ node: Heading, range: NSRange) -> [Style] {
        let attributes: [NSAttributedString.Key: Any]
        switch node.level {
        case .one:
            attributes = [
                .fontTraits: UIFontDescriptor.SymbolicTraits.traitBold,
                .foregroundColor: foregroundColor
            ]

        case .two:
            attributes = [
                .fontTraits: UIFontDescriptor.SymbolicTraits.traitBold
            ]

        case .three:
            attributes = [
                .fontTraits: UIFontDescriptor.SymbolicTraits.traitBold,
                .foregroundColor: secondaryForegroundColor
            ]

        case .four:
            attributes = [
                .fontTraits: UIFontDescriptor.SymbolicTraits.traitBold,
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

        return [
            Style(range: range, attributes: attributes)
        ]
    }

    open override func thematicBreak(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [
                .foregroundColor: delimiterColor,
                .thematicBreak: true,
                .thematicBreakColor: foregroundColor.withAlphaComponent(0.2)
            ])
        ]
    }

    open override func codeInline(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.foregroundColor: secondaryForegroundColor])
        ]
    }

    open override func htmlInline(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.foregroundColor: secondaryForegroundColor])
        ]
    }

    open override func emphasis(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.fontTraits: UIFontDescriptor.SymbolicTraits.traitItalic])
        ] + delimiterStyles(for: node, attributes: [.foregroundColor: delimiterColor])
    }

    open override func strong(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.fontTraits: UIFontDescriptor.SymbolicTraits.traitBold])
        ] + delimiterStyles(for: node, attributes: [.foregroundColor: delimiterColor])
    }

    open override func link(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.foregroundColor: linkColor])
            ] + delimiterStyles(for: node, attributes: [.foregroundColor: linkColor.withAlphaComponent(0.5)]) + urlStyles(for: node, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }

    open override func image(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.foregroundColor: linkColor])
        ] + delimiterStyles(for: node, attributes: [.foregroundColor: linkColor.withAlphaComponent(0.5)]) + urlStyles(for: node, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }

    open override func strikethrough(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        ]
    }

    // MARK: - Initializers

    public override init() {
        super.init()
    }

    // MARK: - Utilities

    func delimiterStyles(for node: Node, attributes: [NSAttributedString.Key: Any]) -> [Style] {
        guard let ranges = node.delimiters else {
            return []
        }

        return ranges.map { range in
            Style(range: range, attributes: attributes)
        }
    }

    func urlStyles(for node: Node, attributes: [NSAttributedString.Key: Any]) -> [Style] {
        guard let urlRange = (node as? Link)?.urlRange else {
            return []
        }

        return [
            Style(range: urlRange, attributes: attributes)
        ]
    }
}
