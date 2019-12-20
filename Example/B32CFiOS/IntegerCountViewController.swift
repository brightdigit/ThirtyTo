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
  
  let encoding = Base32CrockfordEncoding.encoding
  var integerName : IdentifierDataIntName!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    let count = 1
    //encoding.generate(count, from: .default)
    //encoding.generate(1, from: .)
  }


  @IBAction func generate(fromButton button: UIButton, withEvent: UIControl.Event) {
    
  }
  
  @IBAction func valueChanged(fromSlide slider: UISlider, withEvent: UIControl.Event) {
    self.textField.text = "\(slider.value)"
  }
}

