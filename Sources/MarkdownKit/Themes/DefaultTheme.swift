import UIKit

public final class DefaultTheme: Theme {

    // MARK: - Properties

    public let name = "Default"

    public var fontSize: CGFloat = 17

    private let linkColor = UIColor(displayP3Red: 0.129, green: 0.516, blue: 0.686, alpha: 1)
    private let imageColor = UIColor(displayP3Red: 0.546, green: 0.201, blue: 0.719, alpha: 1)

    // MARK: - Theme

    public func attributes(for node: Node) -> [NSAttributedString.Key: Any]? {
        switch node.kind {
        case .heading:
            guard let heading = node as? Heading else {
                assertionFailure("Heading is incorrect model.")
                return nil
            }

            switch heading.level {
            case .one:
                return [
                    .fontTraits: UIFontDescriptor.SymbolicTraits.traitBold,
                    .foregroundColor: UIColor.label
                ]

            case .two:
                return [
                    .fontTraits: UIFontDescriptor.SymbolicTraits.traitBold
                ]

            case .three:
                return [
                    .fontTraits: UIFontDescriptor.SymbolicTraits.traitBold,
                    .foregroundColor: UIColor.secondaryLabel
                ]

            case .four:
                return [
                    .fontTraits: UIFontDescriptor.SymbolicTraits.traitBold,
                    .foregroundColor: UIColor.secondaryLabel
                ]

            case .five:
                return [
                    .foregroundColor: UIColor.secondaryLabel
                ]

            case .six:
                return [
                    .foregroundColor: UIColor.secondaryLabel
                ]
            }

        case .blockquote:
            return [
                .foregroundColor: UIColor.secondaryLabel
            ]

        case .strong:
            return [
                .fontTraits: UIFontDescriptor.SymbolicTraits.traitBold
            ]

        case .emphasis:
            return [
                .fontTraits: UIFontDescriptor.SymbolicTraits.traitItalic
            ]

        case .link, .image:
            return [
                .foregroundColor: UIColor.link
            ]

        case .codeInline, .codeBlock, .htmlInline, .htmlBlock, .table:
            return [
                .foregroundColor: UIColor.secondaryLabel
            ]

        case .strikethrough:
            return [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue
            ]

        default:
            return nil
        }
    }
}
