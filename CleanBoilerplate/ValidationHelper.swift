//
//  ValidationHelper.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 4/27/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation

struct ValidationHelper {
  static func validate(email: String) -> Bool {
    let string = email.trimmingCharacters(in: .whitespacesAndNewlines)
    guard string.characters.count > 0 else {
      return false}
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: string)
    return emailTest
  }
  
  static func validate(password: String) -> Bool {
    let string = password.trimmingCharacters(in: .whitespacesAndNewlines)
    guard string.characters.count > 6 else { return false }
    return true
  }

}
