import MarkdownKit
import XCTest

final class LocationsTests: XCTestCase {
    func testRange() {
        let markdown = "Hello **world**.\n"
        let document = Parser.parse(markdown)!
        XCTAssertEqual(markdown, document.content)

        let paragraph = document.children.first!
        XCTAssertEqual(markdown, paragraph.content)
    }

    func testRangesWithConsecutiveHTMLComments() {
        let markdown = """
<!-- Here's an HTML comment -->
<!-- and a second one with some more content -->
"""
        let document = Parser.parse(markdown)!
        XCTAssertEqual(markdown, document.content)

        let firstLine = document.children.first
        let secondLine = document.children[document.children.startIndex.advanced(by: 1)]

        XCTAssertNotNil(firstLine?.range)
        XCTAssertNil(secondLine.range)
    }
}
