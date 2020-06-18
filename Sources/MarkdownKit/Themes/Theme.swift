import UIKit

public protocol Theme {
    /// Name of the theme
	var name: String { get }

    /// Base font size
	var fontSize: CGFloat { get set }

    /// Primary font
	var font: UIFont { get }

    /// Foreground color
	var foregroundColor: UIColor { get }

    /// Background color
	var backgroundColor: UIColor { get }

    /// Base attributes
    var baseAttributes: [NSAttributedString.Key: Any] { get }

    /// Attributes for a given node
    ///
    /// - parameter node: node to style
    ///
    /// - returns: attributes for the node
	func attributes(for node: Node) -> [NSAttributedString.Key: Any]?
}

extension Theme {
	public var foregroundColor: UIColor {
        .label
	}

	public var backgroundColor: UIColor {
        .systemBackground
	}

    public var fontSize: CGFloat {
        17
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
