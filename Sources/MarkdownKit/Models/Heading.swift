import libcmark

public final class Heading: Node {

	// MARK: - Types

	public enum Level: Int32 {
		case one = 1
		case two = 2
		case three = 3
		case four = 4
		case five = 5
		case six = 6
	}

	// MARK: - Properties

	public var level: Level {
		get {
			let level = cmark_node_get_heading_level(node)
			return Level(rawValue: level) ?? .one
		}

		set {
			cmark_node_set_heading_level(node, newValue.rawValue)
		}
	}
}
