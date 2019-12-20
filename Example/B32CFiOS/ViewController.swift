//
//  ViewController.swift
//  B32CFiOS
//
//  Created by Leo Dion on 12/19/19.
//

import UIKit
import Base32Crockford

class ViewController: UIViewController {
  
  let encoding = Base32CrockfordEncoding.encoding

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    let count = 1
    //encoding.generate(count, from: .default)
    //encoding.generate(1, from: .)
  }


}

