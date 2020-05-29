import MarkdownKit
import XCTest

final class JIRARendererTests: XCTestCase {
	func testHeadings() {
		let markdown = """
		# Heading one
		## Heading two
		"""

		let jira = """
		h1. Heading one
		h2. Heading two
		"""

		XCTAssertEqual(jira, JIRARenderer.render(Parser.parse(markdown)!))
	}

	func testSpans() {
		let markdown = """
		Hello **world**. How is *it* going?

		Here's ~~strikethrough~~ and a `code span`.
		"""

		let jira = """
		Hello *world*. How is _it_ going?
		Here's -strikethrough- and a {{code span}}.
		"""

		XCTAssertEqual(jira, JIRARenderer.render(Parser.parse(markdown)!))
	}
}
