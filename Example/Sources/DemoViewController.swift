import MarkdownKit
import UIKit

final class DemoViewController: UIViewController {

    // MARK: - Properties

    private let textView = TextView()

    // MARK: - UIViewController

    override func loadView() {
        view = textView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.text = """
This is **bold** and __bold__.

Here is *italic* and _italic_.

Here’s ***both***, ___both___, _**both**_, and __*both*__.

Links? We [got ‘em](https://github.com)

Inline `code` too. You can do ```a silly amount of back ticks``` too.

---

```ruby
puts "hi"
```

# Heading 1

## Heading 2

### Heading 3

#### Heading 4

##### Heading 5

###### Heading 6
"""
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let padding: CGFloat = 16
        var insets = view.safeAreaInsets
        insets.top += padding
        insets.right += padding
        insets.bottom += padding
        insets.left += padding
        textView.contentInset = insets
    }
}
