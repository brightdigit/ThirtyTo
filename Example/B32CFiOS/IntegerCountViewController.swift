import Base32Crockford
import UIKit

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
    if let value = type.flatMap({ self.generate?($0) }) {
      print(value)
    }
  }

  @IBAction func valueChanged(fromSlide slider: UISlider, withEvent _: UIControl.Event) {
    textField.text = "\(Int(slider.value))"
  }
}
