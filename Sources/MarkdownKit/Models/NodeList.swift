import libcmark

public struct NodeList: Collection, Sequence {

    // MARK: - Types

    public typealias Iterator = NodeIterator
    public typealias Element = Node
    public typealias Index = Int

    // MARK: - Properties

    let firstNode: Node?

    // MARK: - Initializers

    init(_ firstNode: Node?) {
        self.firstNode = firstNode
    }

    // MARK: - Collection

    public var startIndex: Index {
        return 0
    }

    public var endIndex: Index {
        guard var node = firstNode else {
            return 0
        }

        var count = 1
        while let next = node.next() {
            node = next
            count = index(after: count)
        }

        return count
    }

    public subscript(index: Index) -> Iterator.Element {
        guard var element = firstNode else {
            fatalError("No element")
        }

        var position = 0
        while position < index {
            guard let next = element.next() else {
                fatalError("Index beyond bounds")
            }

            element = next
            position += 1
        }

        return element
    }

    public func index(after i: Index) -> Index {
        return i + 1
    }

    // MARK: - Sequence

    public func makeIterator() -> Iterator {
        return NodeIterator(firstNode: firstNode)
    }
}

public struct NodeIterator: IteratorProtocol {

    // MARK: - Properties

    private let firstNode: Node?
    private var currentNode: Node?

    // MARK: - Initializers

    init(firstNode: Node?) {
        self.firstNode = firstNode
    }

    // MARK: - IteratorProtocol

    public mutating func next() -> Node? {
        if currentNode == nil {
            currentNode = firstNode
        } else {
            currentNode = currentNode?.next()
        }

        return currentNode
    }
}

extension Node {
    fileprivate func next() -> Node? {
        guard let next = cmark_node_next(node) else {
            return nil
        }

        return Node.with(next, document: document)
    }
}
