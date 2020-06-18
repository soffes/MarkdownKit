import libcmark

public final class ListItem: Node {

    // MARK: - Properties

    public var isTask: Bool {
        return String(cString: cmark_node_get_type_string(node)) == "tasklist"
    }

    public var isCompleted: Bool {
        guard let userData = cmark_node_get_user_data(node) else {
            return false
        }

        return Int(bitPattern: userData) == 1
    }
}
