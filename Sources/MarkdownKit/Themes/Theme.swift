import UIKit

/// Theme with some default UIKit colors
open class Theme {

    // MARK: - Properties

    open var foregroundColor: UIColor {
        .label
    }

    open var secondaryForegroundColor: UIColor {
        .secondaryLabel
    }

    open var linkColor: UIColor {
        .link
    }

    open var delimiterColor: UIColor {
        foregroundColor.withAlphaComponent(0.5)
    }

    open var backgroundColor: UIColor {
        .systemBackground
    }

    open var fontSize: CGFloat {
        UIFont.preferredFont(forTextStyle: .body).pointSize
    }

    open var font: UIFont {
        return UIFont(name: "Menlo", size: fontSize)!
    }

    open var baseAttributes: [NSAttributedString.Key: Any] {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineHeightMultiple = 1.25

        return [
            .font: font,
            .foregroundColor: foregroundColor,
            .paragraphStyle: paragraph
        ]
    }

    open func styles(for node: Node, range: NSRange) -> [Style] {
        switch node.kind {
        case .document:
            guard let node = node as? Document else {
                assertionFailure("Expected `Document` node")
                return []
            }

            return document(node, range: range)

        case .blockquote:
            return blockquote(node, range: range)

        case .list:
            return list(node, range: range)

        case .item:
            guard let node = node as? ListItem else {
                assertionFailure("Expected `ListItem` node")
                return []
            }
            return item(node, range: range)

        case .codeBlock:
            return codeBlock(node, range: range)

        case .htmlBlock:
            return htmlBlock(node, range: range)

        case .customBlock:
            return customBlock(node, range: range)

        case .paragraph:
            return paragraph(node, range: range)

        case .heading:
            guard let node = node as? Heading else {
                assertionFailure("Expected `Heading` node")
                return []
            }

            return heading(node, range: range)

        case .thematicBreak:
            return thematicBreak(node, range: range)

        case .table:
            return table(node, range: range)

        case .tableRow:
            return tableRow(node, range: range)

        case .tableCell:
            return tableCell(node, range: range)

        case .text:
            return text(node, range: range)

        case .softBreak:
            return softBreak(node, range: range)

        case .lineBreak:
            return lineBreak(node, range: range)

        case .codeInline:
            return codeInline(node, range: range)

        case .htmlInline:
            return htmlInline(node, range: range)

        case .customInline:
            return customInline(node, range: range)

        case .emphasis:
            return emphasis(node, range: range)

        case .strong:
            return strong(node, range: range)

        case .link:
            return link(node, range: range)

        case .image:
            return image(node, range: range)

        case .strikethrough:
            return strikethrough(node, range: range)

        default:
            assertionFailure("Unknown node kind")
            return []
        }
    }

    open func document(_ node: Document, range: NSRange) -> [Style] {
        []
    }

    open func blockquote(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.foregroundColor: secondaryForegroundColor])
        ]
    }

    open func list(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func item(_ node: ListItem, range: NSRange) -> [Style] {
        []
    }

    open func codeBlock(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.foregroundColor: secondaryForegroundColor])
        ]
    }

    open func htmlBlock(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.foregroundColor: secondaryForegroundColor])
        ]
    }

    open func customBlock(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func paragraph(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func heading(_ node: Heading, range: NSRange) -> [Style] {
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

    open func thematicBreak(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func table(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func tableRow(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func tableCell(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func text(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func softBreak(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func lineBreak(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func codeInline(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.foregroundColor: secondaryForegroundColor])
        ]
    }

    open func htmlInline(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.foregroundColor: secondaryForegroundColor])
        ]
    }

    open func customInline(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func emphasis(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.fontTraits: UIFontDescriptor.SymbolicTraits.traitItalic])
        ] + delimiterStyles(for: node, range: range, attributes: [.foregroundColor: delimiterColor])
    }

    open func strong(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.fontTraits: UIFontDescriptor.SymbolicTraits.traitBold])
        ] + delimiterStyles(for: node, range: range, attributes: [.foregroundColor: delimiterColor])
    }

    open func link(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.foregroundColor: linkColor])
        ]
    }

    open func image(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.foregroundColor: linkColor])
        ]
    }

    open func strikethrough(_ node: Node, range: NSRange) -> [Style] {
        [
            Style(range: range, attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        ]
    }

    // MARK: - Initializers

    public init() {}

    // MARK: - Utilities

    func delimiterStyles(for node: Node, range: NSRange, attributes: [NSAttributedString.Key: Any]) -> [Style] {
        guard let ranges = node.delimiters else {
            return []
        }

        return ranges.map { range in
            Style(range: range, attributes: attributes)
        }
    }
}
