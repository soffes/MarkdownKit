import Foundation

private let bundle = Bundle(for: HTMLFormatter.self)

public final class HTMLFormatter {
	private static let baseStylesheet: String = {
		let url = bundle.url(forResource: "Base", withExtension: "css")!
		return try! String(contentsOf: url)
	}()

	public static func format(html: String, title: String? = nil, isDarkMode: Bool = false, isPrinting: Bool = false)
		-> String
	{
		let url = bundle.url(forResource: isDarkMode ? "Dark" : "Light", withExtension: "css")!
		let stylesheet = try! String(contentsOf: url)
		let additionalStyles: String

		if isPrinting {
			additionalStyles = "body { -webkit-print-color-adjust: exact !important; font-size: 12px; padding: 0; }"
		} else {
			additionalStyles = "body { max-width: 640px; margin: 0 auto; padding: 32px; line-height: 1.4em; font-size: 16px; }"
		}

		// TODO: Escape HTML in `title`
		return """
			<html>
			<head>
			<meta charset="utf-8">
			<title>\(title ?? "")</title>
			<style>
				html { overflow-x: hidden; }
				\(baseStylesheet + additionalStyles + stylesheet)
			</style>
			</head>
			<body>\(html)</body>
			</html>
		"""
	}
}
