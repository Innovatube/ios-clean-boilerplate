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
  func login(email: String, password: String)
  func forgotPassword(email:String)
  func register()
  func facebookLogin()
  func googleSignIn()
}

class LoginInteractor : LoginInteractorInterface {
  var presenter : LoginPresenterInterface!
  var resourceHelper : AccountResourceHelper!
  
  func login(email: String, password: String){
      resourceHelper.login(email: email, password: password).subscribe(onNext: { (_) in
        self.presenter.loginSuccess()
      }) { (_) in
        self.presenter.loginFailed()
    }
  }
  
  func register() {
    
  }
  
  func forgotPassword(email:String) {
    resourceHelper.resetPassword(email: email).subscribe(onNext: { (_) in
      self.presenter.resetPasswordSuccess()
    }, onError: { (_) in
      self.presenter.resetPaswordFailed()
    })
  }
  
  func facebookLogin() {
  }
  
  func googleSignIn() {
    
  }
}
