import Foundation
import libcmark

public final class Document: Node {

    // MARK: - Properties

    /// The text content of the first child if it’s an `<h1>`
    public var title: String? {
        guard let node = firstChild as? Heading, node.level == .one else {
            return nil
        }

        return node.content
    }

    private let _content: String

    // MARK: - Initializers

    init(_ node: UnsafeMutablePointer<cmark_node>, content: String) {
        self._content = content
        super.init(node)
    }

    // MARK: - Node

    public override weak var document: Document? {
        return self
    }

    public override var content: String? {
        return _content
    }

    public override var range: NSRange {
        let string = _content as NSString
        return NSRange(location: 0, length: string.length)
    }
}
