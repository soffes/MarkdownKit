#if os(macOS)
import AppKit
#else
import UIKit
#endif

extension TextStorage {

    // MARK: - Manipulation

    public func toggleBold(in selectedRange: NSRange) {
        toggleSpan(.strong, selectedRange: selectedRange)
    }

    public func toggleItalic(in selectedRange: NSRange) {
        toggleSpan(.emphasis, selectedRange: selectedRange)
    }

    // MARK: - Private

    private func toggleSpan(_ kind: Kind, selectedRange: NSRange) {
        let markdown: String
        let actionName: String

        switch kind {
        case .emphasis:
            markdown = "*"
            actionName = "Italic"
        case .strong:
            markdown = "**"
            actionName = "Bold"
        default:
            assertionFailure("Tried to toggle unsupported span")
            return
        }

        // If it's already this element, remove it.
        guard var node = self.document?.node(for: selectedRange) else {
            return
        }

        let delimiterLength = markdown.length

        if node.kind == .text, let parent = node.parent {
            node = parent
        }

        guard let nodeRange = node.range else {
            return
        }

        if node.kind == kind {
            let innerRange = NSRange(location: nodeRange.location + delimiterLength,
                                     length: nodeRange.length - delimiterLength * 2)
            let replacement = (string as NSString).substring(with: innerRange)
            if !changeTextIn(nodeRange, with: replacement, actionName: actionName) {
                return
            }

            if selectedRange.length == 0 {
                updateSelectedRange(NSRange(location: selectedRange.location - delimiterLength, length: 0))
            } else {
                var updatedSelection = nodeRange
                updatedSelection.length -= delimiterLength * 2
                updateSelectedRange(updatedSelection)
            }
        }

        // No selection, add characters and move cursor.
        else if selectedRange.length == 0 {
            let wordRange = self.string.wordRange(atIndex: selectedRange.location)

            if wordRange.location == NSNotFound {
                return
            }

            // Not inside of a word. Just add the delmiters.
            if wordRange.length == 0 {
                let replacement = "\(markdown)\(markdown)"
                if !changeTextIn(wordRange, with: replacement, actionName: actionName) {
                    return
                }
            }

            // Inside of a word. Toggle the whole word.
            else {
                let string = (self.string as NSString).substring(with: wordRange)
                let replacement = "\(markdown)\(string)\(markdown)"
                if !changeTextIn(wordRange, with: replacement, actionName: actionName) {
                    return
                }
            }

            updateSelectedRange(NSRange(location: selectedRange.location + delimiterLength, length: 0))
        }

        // Selection, add text.
        else {
            let string = (self.string as NSString).substring(with: selectedRange)
            let replacement = "\(markdown)\(string)\(markdown)"

            if !changeTextIn(selectedRange, with: replacement, actionName: actionName) {
                return
            }

            var updatedSelection = selectedRange
            updatedSelection.length += delimiterLength * 2
            updateSelectedRange(updatedSelection)
        }

        parse()
    }

    private func changeTextIn(_ range: NSRange, with replacement: String, actionName: String) -> Bool {
        guard let customDelegate = customDelegate else {
            assertionFailure("Tried to message missing delegate")
            return false
        }

        return customDelegate.textStorage(self, shouldChangeTextIn: range, with: replacement, actionName: actionName)
    }

    private func updateSelectedRange(_ range: NSRange) {
        guard let customDelegate = customDelegate else {
            assertionFailure("Tried to message missing delegate")
            return
        }

        return customDelegate.textStorage(self, didUpdateSelectedRange: range)
    }
}
