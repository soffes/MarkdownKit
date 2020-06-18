import Foundation

extension NSString {
    public func range(start: Location, end: Location?) -> NSRange {
        let bounds = NSRange(location: 0, length: length)

        var startIndex = 0
        var endIndex = 0

        var foundStart = false
        var line = 1

        enumerateSubstrings(in: bounds, options: .byLines) { lineString, _, lineRange, stop in
            guard let lineString = lineString else {
                assertionFailure("Missing line string")
                return
            }

            // Start
            if !foundStart {
                // On the starting line
                if line == start.line {
                    if start.column > 1 {
                        // Add column information (-1 since it’s before)
                        startIndex += self.convertUTF8ToUTF16Length(in: lineString, length: start.column - 1)
                    }

                    foundStart = true
                } else {
                    // Add the entire line
                    startIndex += lineRange.length
                }
            }

            // End
            if let end = end {
                if line == end.line {
                    if end.column > 1 {
                        // Add column information (not -1 since it’s after)
                        endIndex += self.convertUTF8ToUTF16Length(in: lineString, length: end.column)
                    }

                    stop.pointee = true
                    return
                } else {
                    // Add the entire line
                    endIndex += lineRange.length
                }
            } else if foundStart {
                endIndex = NSMaxRange(lineRange)
                stop.pointee = true
                return
            }

            line += 1
        }

        return NSRange(location: startIndex, length: endIndex - startIndex)
    }

    private func convertUTF8ToUTF16Length(in string: String, length: Int) -> Int {
        let utf8 = string.utf8
        let index = utf8.index(utf8.startIndex, offsetBy: length)

        var cString = utf8[utf8.startIndex..<index].map(CChar.init)

        // null terminate
        cString.append(0)

        guard let nsString = NSString(cString: cString, encoding: String.Encoding.utf8.rawValue) else {
            assertionFailure("Failed to convert C string to NSString")
            return 0
        }

        return nsString.length
    }
}
