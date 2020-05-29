import MarkdownKit
import XCTest

final class BlockTests: XCTestCase {

	// MARK: - Features

	func testContent() {
		let markdown = "Hello **world**.\n"
		let document = Parser.parse(markdown)!
		XCTAssertEqual(markdown, document.content)

		let paragraph = document.children.first!
		XCTAssertEqual(markdown, paragraph.content)
	}

	func testLineBreaks() {
		let markdown = "Hello\nworld\n\nTwo\n"
		let document = Parser.parse(markdown)!

		let paragraph1 = document.children[0]
		XCTAssertEqual("Hello\nworld\n", paragraph1.content)

		let paragraph2 = document.children[1]
		XCTAssertEqual("Two\n", paragraph2.content)
	}

	func testRanges() {
		let markdown = "Hello\nworld\n\nTwo\n"
		let document = Parser.parse(markdown)!

		let paragraph1 = document.children[0]
		XCTAssertEqual(NSRange(location: 0, length: 11), paragraph1.range)

		let paragraph2 = document.children[1]
		XCTAssertEqual(NSRange(location: 13, length: 3), paragraph2.range)
	}

	// MARK: - Blocks

	func testBlockQuote() {
		let markdown = "Hello\n\n> World.\n"
		let document = Parser.parse(markdown)!
		XCTAssertEqual(2, document.children.count)

		let block = document.children[1]
		XCTAssertEqual(.blockquote, block.kind)
		XCTAssertEqual(NSRange(location: 7, length: 8), block.range!)
	}

	func testList() {
		let markdown = "Hello\n\n* One\n* Two\n"
		let document = Parser.parse(markdown)!
		XCTAssertEqual(2, document.children.count)

		let block = document.children[1]
		XCTAssertEqual(.list, block.kind)
		XCTAssertEqual(NSRange(location: 7, length: 11), block.range!)
	}

	func testItem() {
		let markdown = "- Item\n\nParagraph\n"
		let document = Parser.parse(markdown)!
		XCTAssertEqual(2, document.children.count)

		let list = document.children[0]
		let block = list.children[0]
		XCTAssertEqual(.item, block.kind)
		XCTAssertEqual(NSRange(location: 0, length: 7), block.range!)
	}

    func testCode() {
        let markdown = "Hello\n\n    puts 'hi'\n"
        let document = Parser.parse(markdown)!
        XCTAssertEqual(2, document.children.count)

        let block = document.children[1]
        XCTAssertEqual(.codeBlock, block.kind)
        XCTAssertEqual(NSRange(location: 11, length: 9), block.range!)
    }

	func testFencedCode() {
		let markdown = "Hello\n\n``` ruby\nputs 'hi'\n```\n"
		let document = Parser.parse(markdown)!
		XCTAssertEqual(2, document.children.count)

		let block = document.children[1]
		XCTAssertEqual(.codeBlock, block.kind)
		XCTAssertEqual(NSRange(location: 7, length: 22), block.range!)
	}

	func testHTML() {
		let markdown = "Hello\n\n<div>\nworld\n</div>\n"
		let document = Parser.parse(markdown)!
		XCTAssertEqual(2, document.children.count)

		let block = document.children[1]
		XCTAssertEqual(.htmlBlock, block.kind)
		XCTAssertEqual(NSRange(location: 7, length: 18), block.range!)
	}

	func testHeading() {
		let markdown = "Hello\n\n# World\n"
		let document = Parser.parse(markdown)!
		XCTAssertEqual(2, document.children.count)

		let block = document.children[1]
		XCTAssertEqual(.heading, block.kind)
		XCTAssertEqual(NSRange(location: 7, length: 7), block.range!)
	}

	func testUnderlinedHeading() {
		let markdown = "Hello\n\nWorld\n=====\n"
		let document = Parser.parse(markdown)!
		XCTAssertEqual(2, document.children.count)

		let block = document.children[1]
		XCTAssertEqual(.heading, block.kind)
		XCTAssertEqual(NSRange(location: 7, length: 11), block.range!)
	}

	func testThematicBreak() {
		let markdown = "Hello\n\n---\n"
		let document = Parser.parse(markdown)!
		XCTAssertEqual(2, document.children.count)

		let block = document.children[1]
		XCTAssertEqual(.thematicBreak, block.kind)
		XCTAssertEqual(NSRange(location: 7, length: 3), block.range!)
	}
}
