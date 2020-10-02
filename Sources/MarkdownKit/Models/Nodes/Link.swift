import libcmark
import Foundation

public class Link: Node {
    public var url: URL? {
        cmark_node_get_url(node).map(String.init).flatMap(URL.init)
    }

    public var urlRange: NSRange? {
        guard let childRange = firstChild?.range, let range = range, range != childRange, let url = url else {
            return nil
        }

        if isAutolink {
            return childRange
        }

        return NSRange(location: NSMaxRange(childRange) + 2, length: (url.absoluteString as NSString).length)
    }

    public var title: String? {
        cmark_node_get_title(node).map(String.init)
    }

    internal var isAutolink: Bool {
        firstChild?.content == url?.absoluteString
    }

    public override var delimiters: [NSRange]? {
        guard let childRange = firstChild?.range, let range = range, range != childRange else {
            return nil
        }

        if isAutolink {
            return [
                NSRange(location: range.location, length: 1),
                NSRange(location: NSMaxRange(range) - 1, length: 1)
            ]
        }

        return [
            NSRange(location: range.location, length: 1),
            NSRange(location: NSMaxRange(childRange), length: 2),
            NSRange(location: NSMaxRange(range) - 1, length: 1)
        ]
    }
}
