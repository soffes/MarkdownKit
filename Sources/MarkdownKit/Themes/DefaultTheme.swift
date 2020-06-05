import UIKit

public final class DefaultTheme: Theme {

	// MARK: - Properties

	public let name = "Default"

	public var fontSize: CGFloat = 17
	public var isDarkModeEnabled = false

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
					.foregroundColor: UIColor(hex: isDarkModeEnabled ? "#fff" : "#000")!
				]

			case .two:
				return [
					.fontTraits: UIFontDescriptor.SymbolicTraits.traitBold
				]

			case .three:
				return [
					.fontTraits: UIFontDescriptor.SymbolicTraits.traitBold,
					.foregroundColor: UIColor(hex: isDarkModeEnabled ? "#b2b2b2" : "#4d4d4d")!
				]

			case .four:
				return [
					.fontTraits: UIFontDescriptor.SymbolicTraits.traitBold,
					.foregroundColor: UIColor(hex: isDarkModeEnabled ? "#7f7f7f" : "#808080")!
				]

			case .five:
				return [
					.foregroundColor: UIColor(hex: isDarkModeEnabled ? "#7f7f7f" : "#808080")!
				]

			case .six:
				return [
					.foregroundColor: UIColor(hex: isDarkModeEnabled ? "#656565" : "#9a9a9a")!
				]
			}

		case .blockquote:
			return [
				.foregroundColor: UIColor(hex: "#3da25f")!
			]

		case .strong:
			return [
				.fontTraits: UIFontDescriptor.SymbolicTraits.traitBold
			]

		case .emphasis:
			return [
				.fontTraits: UIFontDescriptor.SymbolicTraits.traitItalic
			]

		case .link:
			// TODO: title #72c0db
			return [
				.foregroundColor: linkColor
			]

		case .image:
			// TODO: title #b477d2
			return [
				.foregroundColor: imageColor
			]

		case .codeInline, .codeBlock, .htmlInline, .htmlBlock, .table:
			return [
				.foregroundColor: UIColor(hex: "#808080")!
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
