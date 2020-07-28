import libcmark

public final class ListItem: Node {

    // MARK: - Properties

    public var isTask: Bool {
        return String(cString: cmark_node_get_type_string(node)) == "tasklist"
    }

    public var isCompleted: Bool {
        cmark_gfm_extensions_get_tasklist_item_checked(node)
    }
}
