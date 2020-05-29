import cmark

extension String {
	init?(_ buffer: cmark_strbuf) {
		var buffer = buffer
        var utf8String: UnsafePointer<CChar>?
        withUnsafePointer(to: &buffer) { pointer in
            if let string = cmark_strbuf_cstr(pointer) {
                utf8String = string
            }
        }

        guard let string = utf8String else {
            return nil
        }

        self.init(utf8String: string)
	}
}
