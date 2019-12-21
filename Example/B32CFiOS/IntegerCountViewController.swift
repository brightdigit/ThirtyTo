//
//  ViewController.swift
//  B32CFiOS
//
//  Created by Leo Dion on 12/19/19.
//

import UIKit
import Base32Crockford

class IntegerCountViewController: UIViewController {
  
  @IBOutlet weak var label : UILabel!
  @IBOutlet weak var textField : UITextField!
  @IBOutlet weak var slider : UISlider!
  
  var integerName : IdentifierDataIntName!
  var generate: ((IdentifierDataType) -> String)?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    //encoding.generate(count, from: .default)
    //encoding.generate(1, from: .)
    let unit : String
    switch self.integerName {
    case .bytes:
      unit = "Bytes"
    case .minimumCount:
      unit = "Possiblities"
    default:
      unit = ""
    }
    self.label.text = unit
  }


  @IBAction func generate(fromButton button: UIButton, withEvent: UIControl.Event) {
    let type : IdentifierDataType?
    switch self.integerName {
    case .bytes:
      type = .bytes(size: Int(self.slider.value))
    case .minimumCount:
      type = .minimumCount(Int(self.slider.value))
    default:
      type = nil
    }
    if let value = type.flatMap({ self.generate?($0) }) {
      print(value)
    }
  }
  
  @IBAction func valueChanged(fromSlide slider: UISlider, withEvent: UIControl.Event) {
    self.textField.text = "\(Int(slider.value))"
  }
}

