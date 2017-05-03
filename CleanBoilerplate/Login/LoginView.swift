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
    // Please make sure to :
    // - Register your facebook app id 
    // - Config the plist file
    // - Config the app delegate
    // Before uncomment the line below
//    FBSDKLoginManager().logIn(withReadPermissions: ["public_profile"], from: self) { (_, _) in
//      
//    }
    presentInfoAlert(title: "Facebook login required setup", message: "Please go to LoginView/facebookLoginButtonTouched to edit")
  }
  
  func googleSignInButtonTouched(_ button: UIButton){
    // Please make sure to :
    // - Register your google app
    // - Download the googleSetting plist file
    // - Config the app delegate
    // Before uncomment the line below
//    GIDSignIn.sharedInstance().signIn()
    presentInfoAlert(title: "Google login required setup", message: "Please go to LoginView/googleSignInButtonTouched to edit")
  }
  
  func presentInfoAlert(title: String, message: String){
    let alertController =  UIAlertController(title: title, message: message, preferredStyle: .alert)
    let confirmAction = UIAlertAction(title: "OK", style: .cancel)
    alertController.addAction(confirmAction)
    present(alertController, animated: true)
  }
  
  //MARK: LoginViewInterface
  
  func loginSuccess() {
    router.displaySideMenuView()
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

