import libcmark

public final class HTMLRenderer {
	public enum Error: Swift.Error {
		case unknown
	}

	public static func render(_ document: Document) throws -> String {
		var output: UnsafeMutablePointer<Int8>?

		Extensions.allList { list in
			output = cmark_render_html(document.node, CMARK_OPT_UNSAFE, list)
		}

		guard let string = output else {
			throw Error.unknown
		}

		return String(cString: string)
	}
}
