import libcmark

public typealias Kind = cmark_node_type

extension Kind {

	// MARK: - Error

	public static let none: Kind = CMARK_NODE_NONE

	// MARK: - Block

	public static let document: Kind = CMARK_NODE_DOCUMENT
	public static let blockquote: Kind = CMARK_NODE_BLOCK_QUOTE
	public static let list: Kind = CMARK_NODE_LIST
	public static let item: Kind = CMARK_NODE_ITEM
	public static let codeBlock: Kind = CMARK_NODE_CODE_BLOCK
	public static let htmlBlock: Kind = CMARK_NODE_HTML_BLOCK
	public static let customBlock: Kind = CMARK_NODE_CUSTOM_BLOCK
	public static let paragraph: Kind = CMARK_NODE_PARAGRAPH
	public static let heading: Kind = CMARK_NODE_HEADING
	public static let thematicBreak: Kind = CMARK_NODE_THEMATIC_BREAK
	public static let table: Kind = CMARK_NODE_TABLE
	public static let tableRow: Kind = CMARK_NODE_TABLE_ROW
	public static let tableCell: Kind = CMARK_NODE_TABLE_CELL

	// MARK: - Inline

	public static let text: Kind = CMARK_NODE_TEXT
	public static let softBreak: Kind = CMARK_NODE_SOFTBREAK
	public static let lineBreak: Kind = CMARK_NODE_LINEBREAK
	public static let codeInline: Kind = CMARK_NODE_CODE
	public static let htmlInline: Kind = CMARK_NODE_HTML_INLINE
	public static let customInline: Kind = CMARK_NODE_CUSTOM_INLINE
	public static let emphasis: Kind = CMARK_NODE_EMPH
	public static let strong: Kind = CMARK_NODE_STRONG
	public static let link: Kind = CMARK_NODE_LINK
	public static let image: Kind = CMARK_NODE_IMAGE
	public static let strikethrough: Kind = CMARK_NODE_STRIKETHROUGH

	// MARK: - Inspecting

	public var isBlock: Bool {
		switch self {
		case .document, .blockquote, .list, .item, .codeBlock, .htmlBlock, .customBlock, .paragraph, .heading,
			 .thematicBreak, .table, .tableRow, .tableCell:
			return true
		default:
			return false
		}
	}

	public var isInline: Bool {
		switch self {
			case .text, .softBreak, .lineBreak, .codeInline, .htmlInline, .customInline, .emphasis, .strong, .link,
				 .image, .strikethrough:
				return true
		default:
			return false
		}
	}

	public var isCode: Bool {
		switch self {
		case .codeInline, .codeBlock, .htmlInline, .htmlBlock:
			return true
		default:
			return false
		}
	}
}

extension Kind: CustomStringConvertible {
	public var description: String {
		switch self {
		case .document:
			return "document"
		case .blockquote:
			return "blockquote"
		case .list:
			return "list"
		case .item:
			return "item"
		case .codeBlock:
			return "codeBlock"
		case .htmlBlock:
			return "htmlBlock"
		case .customBlock:
			return "customBlock"
		case .paragraph:
			return "paragraph"
		case .heading:
			return "heading"
		case .thematicBreak:
			return "thematicBreak"
		case .table:
			return "table"
		case .tableRow:
			return "tableRow"
		case .tableCell:
			return "tableCell"

		case .text:
			return "text"
		case .softBreak:
			return "softBreak"
		case .lineBreak:
			return "lineBreak"
		case .codeInline:
			return "codeInline"
		case .htmlInline:
			return "htmlInline"
		case .customInline:
			return "customInline"
		case .emphasis:
			return "emphasis"
		case .strong:
			return "strong"
		case .link:
			return "link"
		case .image:
			return "image"
		case .strikethrough:
			return "strikethrough"
		default:
			return "none"
		}
	}
}
