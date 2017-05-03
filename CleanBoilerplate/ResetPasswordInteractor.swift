//
//  ResetPasswordInteractor.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/24/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation

protocol ResetPasswordInteractorInterface {
  func change(email: String)
  func resetPassword()
}

class ResetPasswordInteractor : ResetPasswordInteractorInterface {
  var presenter : ResetPasswordPresenterInterface!
  
  func change(email: String) {
    presenter.email(isValid:ValidationHelper.validate(email: email))
  }
  
  func resetPassword() {
    presenter.resetPasswordSuccess()
  }
}
