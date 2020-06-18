import UIKit

/// Text view configured with custom Text Kit components
public final class TextView: UITextView {

    // MARK: - Properties

    private let customTextContainer = TextContainer()
    private let customLayoutManager = LayoutManager()
    private let customTextStorage = TextStorage()

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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIView

    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if traitCollection.preferredContentSizeCategory != previousTraitCollection?.preferredContentSizeCategory {
            customTextStorage.refreshTheme()
        }
    }

    // MARK: - UITextView

    public override var text: String! {
        didSet {
            customTextStorage.parseIfNeeded()
        }
    }
}

extension TextView: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        customTextStorage.parseIfNeeded()
    }
}
