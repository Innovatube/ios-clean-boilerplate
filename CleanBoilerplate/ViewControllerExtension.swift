//
//  INVViewController.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/21/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import UIKit

extension UIViewController {
  
  func settingButton() -> UIBarButtonItem {
    let settingButton = UIBarButtonItem()
    settingButton.title = "Setting"
    navigationItem.rightBarButtonItem = settingButton
    return settingButton
  }
  
  open func displayError(message: String){
    let alertViewController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    let alertActionConfirm = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alertViewController.addAction(alertActionConfirm)
    present(alertViewController, animated: true, completion: nil)
  }
  
  open func displayConfirmation(message: String, confirmedAction: @escaping (Bool) -> ()?){
    let alertViewController = UIAlertController(title: "Confirm", message: message, preferredStyle: .alert)
    let alertActionConfirm = UIAlertAction(title: "OK", style: .default){ _ in
      confirmedAction(true)
    }
    alertViewController.addAction(alertActionConfirm)
    let alertActionCancel =  UIAlertAction(title: "Cancel", style: .cancel){ _ in
      confirmedAction(false)
    }
    alertViewController.addAction(alertActionCancel)
    present(alertViewController, animated: true, completion: nil)
  }
  
  open func displayActionSheet(message: String, options: [String], selectedOptionAction: @escaping (String) -> () ){
    let alertViewController = UIAlertController(title: "Please select one option", message: message, preferredStyle: .actionSheet)
    
    for option in options {
      let alertAction = UIAlertAction(title: option, style: .default){ _ in
        selectedOptionAction(option)
      }
      alertViewController.addAction(alertAction)
    }
    let alertActionCancel = UIAlertAction(title: nil, style: .cancel, handler: nil)
    alertViewController.addAction(alertActionCancel)
    present(alertViewController, animated: true, completion: nil)
  }
}
