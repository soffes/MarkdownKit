import cmark

public final class JIRARenderer {
	public static func render(_ document: Document) -> String {
		return document.children.map(renderBlock).joined(separator: "\n")
	}

	private static func renderBlock(_ node: Node) -> String {
		if let heading = node as? Heading {
			return "h\(heading.level.rawValue). \(heading.children.map(renderSpan).joined())"
		}

		if node.kind == .lineBreak {
			return "----"
		}

		// TODO: Blockquote
		// TODO: Lists
		// TODO: Tables
		// TODO: Code block

		return node.children.map(renderSpan).joined()
	}

	private static func renderSpan(_ node: Node) -> String {
		let content: String
		if !node.children.isEmpty {
			content = node.children.map(renderSpan).joined()
		} else {
			content = node.content ?? ""
		}

		switch node.kind {
		case .emphasis:
			return "_\(content)_"
		case .strong:
			return "*\(content)*"
		case .strikethrough:
			return "-\(content)-"
		case .codeInline:
			return "{{\(content)}}"
		case .link:
			// TODO: Implement
			return "[Atlassian|http://atlassian.com]"
		case .image:
			// TODO: Implement
			return "!http://www.host.com/image.gif!"
		default:
			return content
		}
	}
}
