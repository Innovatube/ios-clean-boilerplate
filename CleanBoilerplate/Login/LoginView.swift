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
  func loginButton(isValid: Bool)
  func emailField(isValid: Bool)
  func passwordField(isValid: Bool)
  func loginSuccess()
}

class LoginView : UIViewController, LoginViewInterface, UITextFieldDelegate, GIDSignInUIDelegate {
  var interactor : LoginInteractorInterface!
  var router : MainRouter!
  
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  
  @IBOutlet weak var registerButton : UIButton!
  @IBOutlet weak var forgotPasswordButton: UIButton!
  
  @IBOutlet weak var facebookLoginButton: UIButton!
  @IBOutlet weak var googleLoginButton: UIButton!
  
  override func viewDidLoad() {
    GIDSignIn.sharedInstance().uiDelegate = self
    emailField.keyboardType = .emailAddress
    passwordField.keyboardType = .alphabet
    passwordField.isSecureTextEntry = true
    
    UIHelper.customize(textField: emailField)
    UIHelper.customize(textField: passwordField)
    
    setupAction()
  }
  
  func setupAction(){
    emailField.addTarget(self, action: #selector(emailFieldChangedValue(_:)), for: .editingChanged)
    passwordField.addTarget(self, action: #selector(passwordFieldChangedValue(_:)), for: .editingChanged)
    loginButton.addTarget(self, action: #selector(loginButtonTouched(_:)), for: .touchUpInside)
    emailField.delegate = self
    passwordField.delegate = self
    
    registerButton.addTarget(self, action: #selector(registerButtonTouched(_:)), for: .touchUpInside)
    forgotPasswordButton.addTarget(self, action: #selector(forgotPassword(_:)), for: .touchUpInside)
    facebookLoginButton.addTarget(self, action: #selector(facebookLoginButtonTouched(_:)), for: .touchUpInside)
    googleLoginButton.addTarget(self, action: #selector(googleSignInButtonTouched(_:)), for: .touchUpInside)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    switch textField {
    case emailField :
      passwordField.becomeFirstResponder()
    case passwordField:
      passwordField.resignFirstResponder()
      interactor.loginButtonTouched()
    default: break
    }
    return true
  }
  
  func emailFieldChangedValue(_ sender: UITextField){
    guard let string = sender.text else { return }
    interactor.emailFieldChange(value: string)
  }
  func passwordFieldChangedValue(_ sender: UITextField){
    guard let string = sender.text else { return }
    interactor.passwordFieldChange(value: string)
  }
  
  func loginButtonTouched(_ button: UIButton){
    guard emailField.text != nil else { return }
    guard passwordField.text != nil else { return }
    interactor.loginButtonTouched()
  }
  
  func registerButtonTouched(_ button: UIButton){
    router.displayRegisterView()
  }
  
  func forgotPassword(_ button: UIButton){
    router.displayForgotPasswordView()
  }
  
  func facebookLoginButtonTouched(_ button: UIButton){
    FBSDKLoginManager().logIn(withReadPermissions: ["public_profile"], from: self) { (_, _) in
      
    }
  }
  
  func googleSignInButtonTouched(_ button: UIButton){
    GIDSignIn.sharedInstance().signIn()
  }
  
  //MARK: LoginViewInterface
  
  func loginSuccess() {
    router.displayListView()
  }
  
  func loginButton(isValid: Bool) {
    loginButton.isEnabled = isValid
  }
  
  func passwordField(isValid: Bool) {
    passwordField.layer.borderColor = isValid ? UIColor.black.cgColor : UIColor.red.cgColor
  }
  
  func emailField(isValid: Bool) {
    emailField.layer.borderColor = isValid ? UIColor.black.cgColor : UIColor.red.cgColor
  }
}

