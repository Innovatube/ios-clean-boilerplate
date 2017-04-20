//
//  LoginView.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/16/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import UIKit
import GoogleSignIn
import Google
import FBSDKCoreKit
import FBSDKLoginKit

protocol LoginViewInterface {
  func displayErrorLoginMessage()
  func raiseEmailFieldError()
  func raisePasswordFieldError()
  func displayListView()
}

class LoginView : UIViewController, LoginViewInterface, UITextFieldDelegate, GIDSignInUIDelegate {
  var interactor : LoginInteractorInterface!
  var router : MainRouter!
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  
  override func viewDidLoad() {
    GIDSignIn.sharedInstance().uiDelegate = self
  }
  
  @IBAction func loginButtonTouched(_ button: UIButton){
    guard let emailFieldText = emailField.text else {
      return
    }
    guard let passwordFieldText = passwordField.text else {
      return
    }
    interactor.login(email: emailFieldText, password: passwordFieldText)
  }
  
  @IBAction func registerButtonTouched(_ button: UIButton){
    interactor.register()
  }
  
  @IBAction func forgotPassword(_ button: UIButton){
    interactor.forgotPassword(email: "asd")
  }
  
  @IBAction func facebookLoginButtonTouched(_ button: UIButton){
    interactor.facebookLogin()
    FBSDKLoginManager().logIn(withReadPermissions: ["public_profile"], from: self) { (_, _) in
      
    }
  }
  
  @IBAction func googleSignInButtonTouched(_ button: UIButton){
    GIDSignIn.sharedInstance().signIn()
  }
  
  func raiseEmailFieldError() {
    
  }
  
  func raisePasswordFieldError() {
    
  }
  
  func displayErrorLoginMessage() {
    self.displayError(message: "Login error")
  }
  
  func displayListView() {
    router.displayListView()
  }
}

