import UIKit

public protocol Theme {
	var name: String { get }

	var isDarkModeEnabled: Bool { get set }
	var fontSize: CGFloat { get set }

	var font: UIFont { get }
	var foregroundColor: UIColor { get }
	var backgroundColor: UIColor { get }
	var baseAttributes: [NSAttributedString.Key: Any] { get }

	func attributes(for node: Node) -> [NSAttributedString.Key: Any]?
}

extension Theme {
	public var foregroundColor: UIColor {
		return UIColor(hex: isDarkModeEnabled ? "#ddd" : "#222")!
	}

	public var backgroundColor: UIColor {
		return isDarkModeEnabled ? UIColor(hex: "#222")! : .white
	}

	public var font: UIFont {
		return UIFont(name: "Menlo", size: fontSize)!
	}

	public var baseAttributes: [NSAttributedString.Key: Any] {
		let paragraph = NSMutableParagraphStyle()
		paragraph.lineHeightMultiple = 1.25

		return [
			.font: font,
			.foregroundColor: foregroundColor,
			.paragraphStyle: paragraph
		]
	}
}
