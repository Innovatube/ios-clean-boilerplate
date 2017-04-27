//
//  RegisterInteractor.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 4/27/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation

protocol RegisterInteractorInterface {
  func changed(email: String)
  func changed(password: String)
  func changed(repeatPassword: String)
  func registerButtonTouched()
}

class RegisterInteractor : RegisterInteractorInterface {
  var presenter : RegisterPresenterInterface!
  
  private var lastPassword: String = ""
  
  func changed(email: String) {
    presenter.emailField(isValid: ValidationHelper.validate(email: email))
  }
  
  func changed(password: String) {
    lastPassword = password
    presenter.passwordField(isValid: ValidationHelper.validate(password: password))
  }
  
  func changed(repeatPassword: String) {
    presenter.repeatPasswordField(isValid: repeatPassword == lastPassword)
  }
  
  func registerButtonTouched() {
    presenter.registerSuccess()
  }
  
}
