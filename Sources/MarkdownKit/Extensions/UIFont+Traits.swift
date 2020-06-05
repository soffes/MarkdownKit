import UIKit

extension UIFont {
	func addingTraits(_ additionalTraits: UIFontDescriptor.SymbolicTraits) -> UIFont {
		var traits = fontDescriptor.symbolicTraits
		traits.insert(additionalTraits)

		guard let descriptor = fontDescriptor.withSymbolicTraits(traits) else {
			assertionFailure("Failed to create font with symbol traits.")
			return self
		}

        return UIFont(descriptor: descriptor, size: pointSize)
	}

	var hasBoldOrItalicTraits: Bool {
		let traits = fontDescriptor.symbolicTraits
		return traits.contains(.traitBold) || traits.contains(.traitItalic)
	}
}
