//
//  AccountInfoInteractor.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/23/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation

protocol AccountInfoInteractorInterface {
  func requestAccountInfo()
}

class AccountInfoInteractor : AccountInfoInteractorInterface {
  var presenter : AccountInfoPresenterInterface!
  
  func requestAccountInfo() {
  }
  
}
