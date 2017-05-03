//
//  ResetPasswordPresenter.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/24/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation

protocol ResetPasswordPresenterInterface {
  func email(isValid: Bool)
  func resetPasswordSuccess()
}

class ResetPasswordPresenter: ResetPasswordPresenterInterface {
    var view : ResetPasswordViewInterface!
  
  func email(isValid: Bool) {
    view.emailField(isValid: isValid)
    view.resetPasswordButton(isValid: isValid)
  }
  
  func resetPasswordSuccess() {
    view.switchToLoginView()
  }
}
