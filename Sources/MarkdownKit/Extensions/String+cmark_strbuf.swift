import libcmark

extension String {
    init?(_ buffer: cmark_strbuf) {
        var buffer = buffer
        guard let string = cmark_strbuf_cstr(&buffer) else {
            return nil
        }

        self.init(utf8String: string)
    }
}
