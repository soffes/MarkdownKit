import MarkdownKit
import XCTest

final class TextStorageTests: XCTestCase {
    func testRange() {
        let markdown = """
<!-- Here's an HTML comment -->
<!-- and a second one with some more content -->
"""
        let storage = TextStorage()
        storage.replaceCharacters(in: NSRange(location: 0, length: 0), with: markdown)
        XCTAssertNoThrow(storage.parseIfNeeded())
    }
}
