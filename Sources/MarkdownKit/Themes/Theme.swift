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

    open func attributes(for node: Node) -> [NSAttributedString.Key: Any]? {
        switch node.kind {
        case .document:
            guard let node = node as? Document else {
                assertionFailure("Expected `Document` node")
                return nil
            }

            return document(node)

        case .blockquote:
            return blockquote(node)

        case .list:
            return list(node)

        case .item:
            guard let node = node as? ListItem else {
                assertionFailure("Expected `ListItem` node")
                return nil
            }
            return item(node)

        case .codeBlock:
            return codeBlock(node)

        case .htmlBlock:
            return htmlBlock(node)

        case .customBlock:
            return customBlock(node)

        case .paragraph:
            return paragraph(node)

        case .heading:
            guard let node = node as? Heading else {
                assertionFailure("Expected `Heading` node")
                return nil
            }

            return heading(node)

        case .thematicBreak:
            return thematicBreak(node)

        case .table:
            return table(node)

        case .tableRow:
            return tableRow(node)

        case .tableCell:
            return tableCell(node)

        case .text:
            return text(node)

        case .softBreak:
            return softBreak(node)

        case .lineBreak:
            return lineBreak(node)

        case .codeInline:
            return codeInline(node)

        case .htmlInline:
            return htmlInline(node)

        case .customInline:
            return customInline(node)

        case .emphasis:
            return emphasis(node)

        case .strong:
            return strong(node)

        case .link:
            return link(node)

        case .image:
            return image(node)

        case .strikethrough:
            return strikethrough(node)

        default:
            assertionFailure("Unknown node kind")
            return nil
        }
    }

    open func document(_ node: Document) -> [NSAttributedString.Key: Any]? {
        nil
    }

    open func blockquote(_ node: Node) -> [NSAttributedString.Key : Any]? {
        [
            .foregroundColor: secondaryForegroundColor
        ]
    }

    open func list(_ node: Node) -> [NSAttributedString.Key: Any]? {
        nil
    }

    open func item(_ node: ListItem) -> [NSAttributedString.Key: Any]? {
        nil
    }

    open func codeBlock(_ node: Node) -> [NSAttributedString.Key : Any]? {
        [
            .foregroundColor: secondaryForegroundColor
        ]
    }

    open func htmlBlock(_ node: Node) -> [NSAttributedString.Key: Any]? {
        [
            .foregroundColor: secondaryForegroundColor
        ]
    }

    open func customBlock(_ node: Node) -> [NSAttributedString.Key: Any]? {
        nil
    }

    open func paragraph(_ node: Node) -> [NSAttributedString.Key: Any]? {
        nil
    }

    open func heading(_ node: Heading) -> [NSAttributedString.Key: Any]? {
        switch node.level {
        case .one:
            return [
                .fontTraits: UIFontDescriptor.SymbolicTraits.traitBold,
                .foregroundColor: foregroundColor
            ]

        case .two:
            return [
                .fontTraits: UIFontDescriptor.SymbolicTraits.traitBold
            ]

        case .three:
            return [
                .fontTraits: UIFontDescriptor.SymbolicTraits.traitBold,
                .foregroundColor: secondaryForegroundColor
            ]

        case .four:
            return [
                .fontTraits: UIFontDescriptor.SymbolicTraits.traitBold,
                .foregroundColor: secondaryForegroundColor
            ]

        case .five:
            return [
                .foregroundColor: secondaryForegroundColor
            ]

        case .six:
            return [
                .foregroundColor: secondaryForegroundColor
            ]
        }
    }

    open func thematicBreak(_ node: Node) -> [NSAttributedString.Key: Any]? {
        nil
    }

    open func table(_ node: Node) -> [NSAttributedString.Key: Any]? {
        nil
    }

    open func tableRow(_ node: Node) -> [NSAttributedString.Key: Any]? {
        nil
    }

    open func tableCell(_ node: Node) -> [NSAttributedString.Key: Any]? {
        nil
    }

    open func text(_ node: Node) -> [NSAttributedString.Key: Any]? {
        nil
    }

    open func softBreak(_ node: Node) -> [NSAttributedString.Key: Any]? {
        nil
    }

    open func lineBreak(_ node: Node) -> [NSAttributedString.Key: Any]? {
        nil
    }

    open func codeInline(_ node: Node) -> [NSAttributedString.Key : Any]? {
        [
            .foregroundColor: secondaryForegroundColor
        ]
    }

    open func htmlInline(_ node: Node) -> [NSAttributedString.Key : Any]? {
        [
            .foregroundColor: secondaryForegroundColor
        ]
    }

    open func customInline(_ node: Node) -> [NSAttributedString.Key: Any]? {
        nil
    }

    open func emphasis(_ node: Node) -> [NSAttributedString.Key: Any]? {
        [
            .fontTraits: UIFontDescriptor.SymbolicTraits.traitItalic
        ]
    }

    open func strong(_ node: Node) -> [NSAttributedString.Key: Any]? {
        [
            .fontTraits: UIFontDescriptor.SymbolicTraits.traitBold
        ]
    }

    open func link(_ node: Node) -> [NSAttributedString.Key : Any]? {
        [
            .foregroundColor: linkColor
        ]
    }

    open func image(_ node: Node) -> [NSAttributedString.Key : Any]? {
        [
            .foregroundColor: linkColor
        ]
    }

    open func strikethrough(_ node: Node) -> [NSAttributedString.Key: Any]? {
        [
            .strikethroughStyle: NSUnderlineStyle.single.rawValue
        ]
    }


    // MARK: - Initializers

    public init() {}
}
