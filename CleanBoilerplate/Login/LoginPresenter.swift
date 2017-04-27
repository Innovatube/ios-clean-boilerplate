//
//  LoginPresenter.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/16/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation

protocol LoginPresenterInterface {
  func emailField(isValid : Bool)
  func passwordField(isValid : Bool)
  func loginButton(isValid: Bool)
  func login(success: Bool)
}

class LoginPresenter: LoginPresenterInterface {
  var view : LoginViewInterface!
  
  func emailField(isValid: Bool) {
    view.emailField(isValid: isValid)
  }
  
  func passwordField(isValid: Bool) {
    view.passwordField(isValid: isValid)
  }
  
  func login(success: Bool) {
    view.loginSuccess()
  }
  
  func loginButton(isValid: Bool) {
    view.loginButton(isValid: isValid)
  }
}
