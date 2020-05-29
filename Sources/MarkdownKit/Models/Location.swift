public struct Location {
	public var line: Int
	public var column: Int

	public init?(line: Int, column: Int) {
		guard line > 0 && column > 0 else {
			return nil
		}

		self.line = line
		self.column = column
	}
}

extension Location: CustomStringConvertible {
	public var description: String {
		return "\(line):\(column)"
	}
}
