#if os(iOS)
import UIKit

/// Text view configured with custom Text Kit components
open class TextView: UITextView {

    // MARK: - Properties

    public let customTextContainer = TextContainer()
    public let customLayoutManager = LayoutManager()
    public let customTextStorage = TextStorage()

    // MARK: - Initializers

    public init() {
        customLayoutManager.addTextContainer(customTextContainer)
        customTextStorage.addLayoutManager(customLayoutManager)

        super.init(frame: .zero, textContainer: customTextContainer)

        delegate = self
        smartDashesType = .no
        smartQuotesType = .no
        typingAttributes = customTextStorage.typingAttributes
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIView

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory {
            customTextStorage.refreshTheme()
        }
    }

    // MARK: - UITextView

    open override var text: String! {
        didSet {
            customTextStorage.parseIfNeeded()
        }
    }
}

extension TextView: UITextViewDelegate {
    open func textViewDidChange(_ textView: UITextView) {
        customTextStorage.parseIfNeeded()
    }
}
#endif
