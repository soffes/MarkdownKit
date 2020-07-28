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
}
