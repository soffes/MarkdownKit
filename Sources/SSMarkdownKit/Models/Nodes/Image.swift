import Foundation

public final class Image: Link {
    public override var delimiters: [NSRange]? {
        guard var delimiters = super.delimiters else {
            return nil
        }

        delimiters[0].length = 2
        return delimiters
    }
}
