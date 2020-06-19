import MarkdownKit
import UIKit

private let exampleDocument = """
This is **bold** and __bold__.

Here is *italic* and _italic_.

Here’s ***both***, ___both___, _**both**_, and __*both*__.

Links? We [got ‘em](https://github.com)

This is an image ![reef](https://soffes.s3.amazonaws.com/reef.jpg)

This is ~~strikethrough~~.

Inline `code` too. You can do ```a silly amount of back ticks``` too.

---

> Blockquote

- List
* List

1. One
1. Two

- [ ] Task list
- [x] Done

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

final class DemoViewController: UIViewController {

    // MARK: - Properties

    private let textView: TextView = {
        let view = TextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = exampleDocument
        view.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return view
    }()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(textView)

        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blur.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blur)

        let blurBottom = blur.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -1)
        blurBottom.priority = .defaultHigh

        NSLayoutConstraint.activate([
            blur.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blur.topAnchor.constraint(equalTo: view.topAnchor),
            blurBottom,

            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide),
                                       name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillChange),
                                       name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }

    // MARK: - Private

    @objc func keyboardWillHide(_ notification: Notification) {
        textView.contentInset = .zero
        textView.verticalScrollIndicatorInsets = textView.contentInset
        textView.scrollRangeToVisible(textView.selectedRange)
    }

    @objc func keyboardWillChange(_ notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        textView.contentInset = UIEdgeInsets(top: 0, left: 0,
                                             bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)

        textView.verticalScrollIndicatorInsets = textView.contentInset
        textView.scrollRangeToVisible(textView.selectedRange)
    }
}
