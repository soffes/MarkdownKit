import MarkdownKit
import XCTest

final class InlineTests: XCTestCase {

    // MARK: - Features

    func testContent() {
        let markdown = "This is **bold**.\n"
        let document = Parser.parse(markdown)!
        let node = document.children[0].children[1].children[0]
        XCTAssertEqual("bold", node.content)
    }

    func testMultibyte() {
        let markdown = "Ya’ll **bóld**.\n"
        let document = Parser.parse(markdown)!
        let node = document.children[0].children[1]
        XCTAssertEqual(NSRange(location: 6, length: 8), node.range!)
    }

    func testEmoji() {
        let markdown = "This is 🇺🇸 **bo👨‍👩‍👧‍👦ld**.\n"
        let document = Parser.parse(markdown)!
        let node = document.children[0].children[1]
        XCTAssertEqual(NSRange(location: 13, length: 19), node.range!)
    }

    // MARK: - Inlines

    func testInlineCode() {
        let markdown = "Hello ````world````.\n"
        let document = Parser.parse(markdown)!

        let paragraph = document.children[0]
        XCTAssertEqual(3, paragraph.children.count)

        let node = paragraph.children[1]
        XCTAssertEqual(NSRange(location: 6, length: 13), node.range!)
        XCTAssertEqual(.codeInline, node.kind)
    }

    func testMultiInlineCode() {
        let markdown = "Hello `world`.\n"
        let document = Parser.parse(markdown)!

        let paragraph = document.children[0]
        XCTAssertEqual(3, paragraph.children.count)

        let node = paragraph.children[1]
        XCTAssertEqual(NSRange(location: 6, length: 7), node.range!)
        XCTAssertEqual(.codeInline, node.kind)
    }

    func testNotInlineCode() {
        let markdown = "Hello `world\n"
        let document = Parser.parse(markdown)!

        let paragraph = document.children[0]
        XCTAssertEqual(1, paragraph.children.count)
        XCTAssertEqual(.text, paragraph.children[0].kind)
    }

    func testInlineHTML() {
        let markdown = "Hello <mark>world</mark>.\n"
        let document = Parser.parse(markdown)!

        let paragraph = document.children[0]
        XCTAssertEqual(5, paragraph.children.count)

        let node = paragraph.children[1]
        XCTAssertEqual(NSRange(location: 6, length: 6), node.range!)
        XCTAssertEqual(.htmlInline, node.kind)
    }

    func testEmphasis() {
        let markdown = "Hello *world*.\n"
        let document = Parser.parse(markdown)!

        let paragraph = document.children[0]
        XCTAssertEqual(3, paragraph.children.count)

        let node = paragraph.children[1]
        XCTAssertEqual(NSRange(location: 6, length: 7), node.range!)
        XCTAssertEqual(.emphasis, node.kind)
    }

    func testStrong() {
        let markdown = "Hello **world**.\n"
        let document = Parser.parse(markdown)!

        let paragraph = document.children[0]
        XCTAssertEqual(3, paragraph.children.count)

        let node = paragraph.children[1]
        XCTAssertEqual(NSRange(location: 6, length: 9), node.range!)
        XCTAssertEqual(.strong, node.kind)
    }

    func testLink() {
        let markdown = "Hello [world](http://example.com \"Example\").\n"
        let document = Parser.parse(markdown)!

        let paragraph = document.children[0]
        XCTAssertEqual(3, paragraph.children.count)

        let node = paragraph.children[1]
        XCTAssertEqual(NSRange(location: 6, length: 37), node.range!)
        XCTAssertEqual(.link, node.kind)
    }

    func testImage() {
        let markdown = "Hello ![world](http://example.com/world.jpg).\n"
        let document = Parser.parse(markdown)!

        let paragraph = document.children[0]
        XCTAssertEqual(3, paragraph.children.count)

        let node = paragraph.children[1]
        XCTAssertEqual(NSRange(location: 6, length: 38), node.range!)
        XCTAssertEqual(.image, node.kind)
    }

    func testStrikethrough() {
        let markdown = "Hello ~~world~~.\n"
        let document = Parser.parse(markdown)!

        let paragraph = document.children[0]
        XCTAssertEqual(3, paragraph.children.count)

        let node = paragraph.children[1]
        XCTAssertEqual(NSRange(location: 6, length: 9), node.range!)
        XCTAssertEqual(.strikethrough, node.kind)
    }

    func testBoldItalic() {
        let markdown = "Hello ***world***.\n"
        let document = Parser.parse(markdown)!

        let paragraph = document.children[0]
        XCTAssertEqual(3, paragraph.children.count)

        let emphasis = paragraph.children[1]
        XCTAssertEqual(NSRange(location: 6, length: 11), emphasis.range!)
        XCTAssertEqual(.emphasis, emphasis.kind)

        let strong = emphasis.children[0]
        XCTAssertEqual(NSRange(location: 6, length: 11), strong.range!)
        XCTAssertEqual(.strong, strong.kind)
    }
}
