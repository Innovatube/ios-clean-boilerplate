//
//  AccountInfoView.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/23/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import UIKit

protocol AccountInfoViewInterface {
  func displayAccountInfo()
  func loadingAccountFailed()
}

class AccountInfoView : UIViewController, AccountInfoViewInterface {
  var interactor : AccountInfoInteractorInterface!
  var router: MainRouter!
  
  override func viewDidLoad() {
    interactor.requestAccountInfo()
  }
  
  func displayAccountInfo(){
    
  }
  
  func loadingAccountFailed(){
    
  }

}
