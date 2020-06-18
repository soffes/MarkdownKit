import UIKit

/// Fast, concrete text storage intended to be subclassed.
public class BaseTextStorage: NSTextStorage {

    // MARK: - Properties

    private let storage = NSMutableAttributedString()

    // MARK: - NSTextStorage

    public override var string: String {
        return storage.string
    }

    public override func attributes(at location: Int, effectiveRange range: NSRangePointer?)
        -> [NSAttributedString.Key: Any]
    {
        assert(location < length,
               "Tried to access attributes at out of bounds index \(location). Length: \(length)")
        return storage.attributes(at: location, effectiveRange: range)
    }

    public override func replaceCharacters(in range: NSRange, with string: String) {
        assert(NSMaxRange(range) <= length,
               "Tried to replace characters at out of bounds range \(range). Length: \(length)")

        let stringLength = (string as NSString).length
        if range.length == 0 && stringLength == 0 {
            return
        }

        beginEditing()
        storage.replaceCharacters(in: range, with: string)
        edited(.editedCharacters, range: range, changeInLength: stringLength - range.length)
        endEditing()
    }

    public override func setAttributes(_ attributes: [NSAttributedString.Key: Any]?, range: NSRange) {
        assert(NSMaxRange(range) <= self.length,
               "Tried to set attributes at out of bounds range \(range). Length: \(length)")

        beginEditing()
        storage.setAttributes(attributes, range: range)
        edited(.editedAttributes, range: range, changeInLength: 0)
        endEditing()
    }
}
