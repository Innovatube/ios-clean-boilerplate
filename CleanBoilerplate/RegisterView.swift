//
//  RegisterView.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 4/27/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import UIKit

protocol RegisterViewInterface {
  func emailField(isValid: Bool)
  func passwordField(isValid: Bool)
  func repeatPasswordField(isValid: Bool)
  func registerButton(isValid: Bool)
  func switchToLoginView()
}

class RegisterView : UIViewController, RegisterViewInterface, UITextFieldDelegate {
  
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var repeatPasswordField: UITextField!
  @IBOutlet weak var registerButton: UIButton!
  
  var interactor : RegisterInteractorInterface!
  var router : MainRouter!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    customizeField()
    
    setupAction()
    emailField.becomeFirstResponder()
  }
  
  func customizeField() {
    [emailField, passwordField, repeatPasswordField].forEach { (field) in
      UIHelper.customize(textField: field)
    }
    emailField.keyboardType = .emailAddress
    passwordField.isSecureTextEntry = true
    passwordField.keyboardType = .alphabet
    repeatPasswordField.isSecureTextEntry = true
    repeatPasswordField.keyboardType = .alphabet
  }
  
  func setupAction() {
    emailField.delegate = self
    passwordField.delegate = self
    repeatPasswordField.delegate = self
    
    emailField.addTarget(self, action: #selector(emailFieldChangedValue(_:)), for: .editingChanged)
    passwordField.addTarget(self, action: #selector(passwordFieldChangedValue(_:)), for: .editingChanged)
    repeatPasswordField.addTarget(self, action: #selector(repeatPasswordChangedValue(_:)), for: .editingChanged)
    registerButton.addTarget(self, action: #selector(registerButtonTouched), for: .touchUpInside)
  }
  
  func emailFieldChangedValue(_ sender: UITextField){
    guard let string = sender.text else { return }
    interactor.changed(email: string)
  }
  
  func passwordFieldChangedValue(_ sender: UITextField){
    guard let string = sender.text else { return }
    interactor.changed(password: string )
  }
  
  func repeatPasswordChangedValue(_ sender: UITextField){
    guard let string = sender.text else { return }
    interactor.changed(repeatPassword: string)
  }
  
  func registerButtonTouched(){
    interactor.registerButtonTouched()
  }
  
  //MARK: RegisterViewInterface
  
  func switchToLoginView() {
    router.navigationController.popViewController(animated: true)
  }
  
  func emailField(isValid: Bool) {
    set(field: emailField, validity: isValid)
  }
  
  func passwordField(isValid: Bool) {
    set(field: passwordField, validity: isValid)
  }
  
  func repeatPasswordField(isValid: Bool) {
    set(field: repeatPasswordField, validity: isValid)
  }
  
  func registerButton(isValid: Bool) {
    registerButton.isEnabled = isValid
  }
  
  func set(field: UITextField, validity: Bool){
    field.layer.borderColor = validity ? UIColor.black.cgColor : UIColor.red.cgColor
  }
  
}
