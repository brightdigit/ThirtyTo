import Base32Crockford
import UIKit

extension IdentifierDataType: CustomStringConvertible {
  public var description: String {
    switch self {
    case .default:
      return "Single Default"
    case .uuid:
      return "UUID"
    case let .bytes(size):
      return "\(size) bytes"
    case let .minimumCount(count):
      return "Minimum Count of \(count)"
    @unknown default:
      return "Unknown"
    }
  }
}

class IntegerCountViewController: UIViewController {
  @IBOutlet var label: UILabel!
  @IBOutlet var textField: UITextField!
  @IBOutlet var slider: UISlider!

  var integerName: IdentifierDataIntName!
  var generate: ((IdentifierDataType) -> String)?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    // encoding.generate(count, from: .default)
    // encoding.generate(1, from: .)
    let unit: String
    switch integerName {
    case .bytes:
      unit = "Bytes"
    case .minimumCount:
      unit = "Possiblities"
    default:
      unit = ""
    }
    label.text = unit
  }

  @IBAction func generate(fromButton _: UIButton, withEvent _: UIControl.Event) {
    let type: IdentifierDataType?
    switch integerName {
    case .bytes:
      type = .bytes(size: Int(slider.value))
    case .minimumCount:
      type = .minimumCount(Int(slider.value))
    default:
      type = nil
    }
    guard let actualType = type else {
      return
    }
    guard let value = generate?(actualType) else {
      return
    }
    let controller = UIAlertController(title: actualType.description, message: value, preferredStyle: .alert)
    controller.addAction(UIAlertAction(title: "OK", style: .default, handler: {
      _ in
      controller.dismiss(animated: true)
      }))
    present(controller, animated: true)
  }

  @IBAction func valueChanged(fromSlide slider: UISlider, withEvent _: UIControl.Event) {
    textField.text = "\(Int(slider.value))"
  }
}
