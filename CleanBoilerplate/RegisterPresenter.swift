//
//  RegisterPresenter.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 4/27/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation

protocol RegisterPresenterInterface {
  func emailField(isValid: Bool)
  func passwordField(isValid: Bool)
  func repeatPasswordField(isValid: Bool)
  func registerSuccess()
}

class RegisterPresenter: RegisterPresenterInterface {
  var view : RegisterViewInterface!
  
  private var emailIsValid: Bool = false {
    didSet { view.emailField(isValid: emailIsValid) }
  }
  private var passwordIsValid: Bool = false {
    didSet { view.passwordField(isValid: passwordIsValid) }
  }
  private var repeatPasswordIsValid: Bool = false {
    didSet { view.repeatPasswordField(isValid: repeatPasswordIsValid) }
  }
  
  private var registerFormIsValid: Bool {
    return emailIsValid && passwordIsValid && repeatPasswordIsValid
  }
  
  func emailField(isValid: Bool) {
    emailIsValid = isValid
    view.registerButton(isValid: registerFormIsValid)
  }
  
  func passwordField(isValid: Bool) {
    passwordIsValid = isValid
    view.registerButton(isValid: registerFormIsValid)
  }
  
  func repeatPasswordField(isValid: Bool) {
    repeatPasswordIsValid = isValid
    view.registerButton(isValid: registerFormIsValid)
  }
  
  func registerSuccess() {
    view.switchToLoginView()
  }
  
}
