#if os(macOS)
import AppKit
#else
import UIKit
#endif

public final class TextContainer: NSTextContainer {

    // MARK: - Initializers

    override init(size: CGSize) {
        super.init(size: size)
        lineFragmentPadding = 0
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
