//
//  LoginInteractor.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/16/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation
import RxSwift

protocol LoginInteractorInterface {
  func emailFieldChange(value: String)
  func passwordFieldChange(value: String)
  func loginButtonTouched()
}

class LoginInteractor : LoginInteractorInterface {
  var presenter : LoginPresenterInterface!
//  var resourceHelper : AccountResourceHelper!
  
  var emailFieldValidState : Bool = false {
    didSet { presenter.emailField(isValid: emailFieldValidState) }
  }
  var passwordFieldValidState : Bool = false {
    didSet { presenter.passwordField(isValid: passwordFieldValidState) }
  }
  var loginButtonValidState : Bool {
    return emailFieldValidState && passwordFieldValidState
  }
  
//  MARK: LoginInteractorInterface
  
  func emailFieldChange(value: String) {
    emailFieldValidState = ValidationHelper.validate(email: value)
    presenter.loginButton(isValid: loginButtonValidState)
  }
  
  func passwordFieldChange(value: String) {
    passwordFieldValidState = ValidationHelper.validate(password: value)
    presenter.loginButton(isValid: loginButtonValidState)
  }
  
  func loginButtonTouched() {
//    resourceHelper.login(email: email, password: password).subscribe(onNext: { (_) in
//      self.presenter.login(success: true)
//    }) { (_) in
//      self.presenter.login(success: false)
//    }
    presenter.login(success: true)
  }
  
  
  
}
