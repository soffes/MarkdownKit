import Foundation

extension String {
	var length: Int {
		return (self as NSString).length
	}

	func wordRange(atIndex index: Int) -> NSRange {
		if index > length {
			return NSRange(location: length, length: 0)
		}

		let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
		tagger.string = self

		var range = NSRange(location: 0, length: 0)
		let tag = tagger.tag(at: index, scheme: .tokenType, tokenRange: &range, sentenceRange: nil)

		if tag == .word {
			return range
		}

		// TODO: Handle this
		return NSRange(location: NSNotFound, length: 0)
	}

	func word(atIndex index: Int) -> String {
		let range = wordRange(atIndex: index)

		if range.location == NSNotFound {
			return ""
		}

		return (self as NSString).substring(with: range)
	}
}
