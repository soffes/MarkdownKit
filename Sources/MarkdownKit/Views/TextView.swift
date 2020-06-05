import UIKit

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

    // MARK: - UITextView

    public override var text: String! {
        didSet {
            parse()
        }
    }

    // MARK: - Private

    private func parse() {
        customTextStorage.parseIfNeeded()
    }
}

extension TextView: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        parse()
    }
}
