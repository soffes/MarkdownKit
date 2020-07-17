import Foundation

public final class ThematicBreak: Link {
    public override var delimiters: [NSRange]? {
        range.flatMap { [$0] }
    }
}
