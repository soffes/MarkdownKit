import Foundation
import libcmark

public final class Document: Node {

    // MARK: - Properties

    public var title: String? {
        return children.first { ($0 as? Heading)?.level == .one }?.content
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
