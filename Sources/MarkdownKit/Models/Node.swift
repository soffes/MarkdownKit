import Foundation
import cmark

public class Node {

	// MARK: - Properties

	/// Underlying `cmark_node` pointer
	let node: UnsafeMutablePointer<cmark_node>

	/// Node type
	public var kind: Kind {
		return cmark_node_get_type(node)
	}

	public var parent: Node? {
		return cmark_node_parent(node).map { Node.with($0, document: document) }
	}

	/// All child nodes
	public var children: NodeList {
		guard let child = cmark_node_first_child(node) else {
			return NodeList(nil)
		}

		return NodeList(Node.with(child, document: document))
	}

	/// Start location
	public var start: Location? {
		return Location(line: Int(cmark_node_get_start_line(node)), column: Int(cmark_node_get_start_column(node)))
	}

	/// End location
	public var end: Location? {
		return Location(line: Int(cmark_node_get_end_line(node)), column: Int(cmark_node_get_end_column(node)))
	}

	/// String content
	///
	/// - note: This is only present for block nodes and inline `text` ndoes.
	public var content: String? {
		return cmark_node_get_literal(node).map(String.init) ?? String(node.pointee.content)
	}

	public private(set) weak var document: Document?

	/// Range of the node in the document’s string
	public var range: NSRange? {
		guard let start = start else {
//			assertionFailure("Missing `start`")
			return nil
		}

		guard let content = document?.content.map(NSString.init) else {
			assertionFailure("Missing `document.content`")
			return nil
		}

		var range = content.range(start: start, end: end)
		let max = NSMaxRange(range)
		let contentLength = content.length

		// cmark sometimes adds an extra character since internally it always ensures the string ends with a new line.
		// If it's longer than the document’s string, just clip off the end.
		if max > contentLength {
			range.length -= contentLength - max
		}

		return range
	}

	/// Recursive description
	public var recursiveDescription: String {
		var output = description

		children.forEach { node in
			for line in node.recursiveDescription.split(separator: "\n") {
				output += "\n    \(line)"
			}
		}

		return output
	}

	// MARK: - Initializers

	/// Initialize with a `cmark_node` pointer
	init(_ node: UnsafeMutablePointer<cmark_node>, document: Document? = nil) {
		self.node = node
		self.document = document
	}

	static func with(_ node: UnsafeMutablePointer<cmark_node>, document: Document? = nil) -> Node {
		switch cmark_node_get_type(node) {
		case .heading:
			return Heading(node, document: document)
		case .item:
			return ListItem(node, document: document)
		default:
			return Node(node, document: document)
		}
	}

	// MARK: - Querying

	public func contains(_ index: Int) -> Bool {
		return range.flatMap { $0.contains(index) } ?? false
	}

	/// Find the deepest node at `index`.
	///
	/// If `kind` is specified, it will stop at the first node of that kind at `index`.
	public func node(at index: Int, kind: Kind? = nil) -> Node? {
		guard contains(index) else {
			return nil
		}

		guard let match = children.first(where: { $0.contains(index) }) else {
			return self
		}

		if match.kind == kind {
			return match
		}

		return match.node(at: index, kind: kind) ?? match
	}

	public func node(for range: NSRange) -> Node? {
		guard let selfRange = self.range else {
			return nil
		}

		// The range is invalid
		var range = range
		if NSIntersectionRange(selfRange, range).length == 0 {
			range.length = 1
		}

		if NSIntersectionRange(selfRange, range).length == 0 {
			return nil
		}

		for child in children {
			if NSIntersectionRange(selfRange, range).length > 0 {
				if let match = child.node(for: range) {
					return match
				}
			}
		}

		return self
	}
}

extension Node: CustomStringConvertible {
	public var description: String {
		return "<Node kind: \(kind)>"
	}
}
