#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// Base theme with very minimal styling
open class Theme {

    // MARK: - Properties

    open var foregroundColor: Color {
#if os(macOS)
        return NSColor.labelColor
#else
        return UIColor.label
#endif
    }

    open var backgroundColor: Color {
#if os(macOS)
        return NSColor.textBackgroundColor
#else
        return UIColor.systemBackground
#endif
    }

    open var font: Font {
#if os(macOS)
        return NSFont.systemFont(ofSize: NSFont.systemFontSize)
#else
        return UIFont.preferredFont(forTextStyle: .body)
#endif
    }

    open var baseAttributes: [NSAttributedString.Key: Any] {
        [
            .font: font,
            .foregroundColor: foregroundColor
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
            guard let node = node as? ThematicBreak else {
                assertionFailure("Expected `ThematicBreak` node")
                return []
            }

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
            guard let node = node as? Link else {
                assertionFailure("Expected `Link` node")
                return []
            }

            return link(node, range: range)

        case .image:
            guard let node = node as? Image else {
                assertionFailure("Expected `Image` node")
                return []
            }

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
        []
    }

    open func list(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func item(_ node: ListItem, range: NSRange) -> [Style] {
        []
    }

    open func codeBlock(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func htmlBlock(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func customBlock(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func paragraph(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func heading(_ node: Heading, range: NSRange) -> [Style] {
        []
    }

    open func thematicBreak(_ node: ThematicBreak, range: NSRange) -> [Style] {
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
        []
    }

    open func htmlInline(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func customInline(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func emphasis(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func strong(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    open func link(_ node: Link, range: NSRange) -> [Style] {
        []
    }

    open func image(_ node: Image, range: NSRange) -> [Style] {
        []
    }

    open func strikethrough(_ node: Node, range: NSRange) -> [Style] {
        []
    }

    // MARK: - Initializers

    public init() {}
}
