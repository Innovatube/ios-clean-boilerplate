//
//  UIHelper.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 4/27/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import UIKit

struct UIHelper {
  static func customize(textField: UITextField){
    textField.layer.borderWidth = 1
    textField.layer.masksToBounds = true
    textField.layer.cornerRadius = 8
  }
}
