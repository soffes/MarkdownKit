import cmark

struct Extensions {

	// MARK: - GitHub Extensions

	static let strikethroughExtension = create_strikethrough_extension()
	static let tableExtension = create_table_extension()
	static let taskListExtension = create_tasklist_extension()

	// MARK: - Properties

	static let all = [
		strikethroughExtension,
		tableExtension,
		taskListExtension
	]

	// MARK: - Enumerating

	static func allList(_ closure: (UnsafeMutablePointer<cmark_llist>?) -> Void) {
		var list: UnsafeMutablePointer<cmark_llist>?
		let memory = cmark_get_default_mem_allocator()

		for var ext in all {
			list = cmark_llist_append(memory, list, &ext)
		}

		closure(list)

		cmark_llist_free(memory, list)
	}
}
