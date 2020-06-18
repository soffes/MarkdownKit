import libcmark

public struct Parser {

    // MARK: - Types

    public struct Option: OptionSet {
        public let rawValue: Int32

        public init(rawValue: Int32) {
            self.rawValue = rawValue
        }

        /// Normalize tree by consolidating adjacent text nodes.
        public static let normalize = Option(rawValue: CMARK_OPT_NORMALIZE)

        /// Validate UTF-8 in the input before parsing, replacing illegal sequences with the replacement character
        /// `U+FFFD`.
        public static let validateUTF8 = Option(rawValue: CMARK_OPT_VALIDATE_UTF8)

        /// Convert straight quotes to curly, --- to em dashes, -- to en dashes.
        public static let smart = Option(rawValue: CMARK_OPT_SMART)
    }

    // MARK: - Parsing

    public static func parse(_ string: String, options: Option = []) -> Document? {
        let parser = cmark_parser_new(options.rawValue)
        Extensions.all.forEach { cmark_parser_attach_syntax_extension(parser, $0) }

        string.withCString {
            let stringLength = Int(strlen($0))
            cmark_parser_feed(parser, $0, stringLength)
        }

        let tree = cmark_parser_finish(parser)
        cmark_parser_free(parser)

        return tree.map { Document($0, content: string) }
    }
}
