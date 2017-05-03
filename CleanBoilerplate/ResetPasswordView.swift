//
//  ResetPasswordView.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/24/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import UIKit

protocol ResetPasswordViewInterface {
  func emailField(isValid: Bool)
  func resetPasswordButton(isValid: Bool)
  func switchToLoginView()
}

class ResetPasswordView : UIViewController, ResetPasswordViewInterface {
  var interactor : ResetPasswordInteractorInterface!
  var router : MainRouter!
  
  @IBOutlet weak var emailField : UITextField!
  @IBOutlet weak var resetPasswordButton: UIButton!
  
  override func viewDidLoad() {
    UIHelper.customize(textField: emailField)
    resetPasswordButton.isEnabled = false
    setupAction()
  }
  
  func setupAction(){
    emailField.addTarget(self, action: #selector(emailFieldChangeValue(_:)), for: .editingChanged)
    resetPasswordButton.addTarget(self, action: #selector(resetPasswordTouched(_:)), for: .touchUpInside)
  }
  
  func emailFieldChangeValue(_ sender: UITextField!){
    guard let string = sender.text else { return }
    interactor.change(email: string)
  }
  
  func resetPasswordTouched(_ sender: UIButton!){
    interactor.resetPassword()
  }
  
  func emailField(isValid: Bool){
    emailField.layer.borderColor = isValid ? UIColor.black.cgColor : UIColor.red.cgColor
  }
  
  func resetPasswordButton(isValid: Bool){
    resetPasswordButton.isEnabled = isValid
  }
  
  func switchToLoginView() {
    router.navigationController.popViewController(animated: true)
  }
}
