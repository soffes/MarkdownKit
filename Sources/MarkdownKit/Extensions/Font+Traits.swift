#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension Font {
    func addingTraits(_ additionalTraits: FontSymbolicTraits) -> Font {
        var traits = fontDescriptor.symbolicTraits
        traits.insert(additionalTraits)

        #if os(macOS)
        let descriptor = fontDescriptor.withSymbolicTraits(traits)
        #else
        guard let descriptor = fontDescriptor.withSymbolicTraits(traits) else {
            assertionFailure("Failed to create font with symbol traits.")
            return self
        }
        #endif

        #if os(macOS)
        guard let font = NSFont(descriptor: descriptor, size: pointSize) else {
            assertionFailure("Failed to create font with symbol traits.")
            return self
        }

        return font
        #else
        return UIFont(descriptor: descriptor, size: pointSize)
        #endif
    }

    var hasBoldOrItalicTraits: Bool {
        let traits = fontDescriptor.symbolicTraits
        return traits.contains(.traitBold) || traits.contains(.traitItalic)
    }
}
