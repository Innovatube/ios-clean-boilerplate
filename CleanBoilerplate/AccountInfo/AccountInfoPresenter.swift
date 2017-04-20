//
//  AccountInfoPresenter.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/23/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation

protocol AccountInfoPresenterInterface {
  func display(accountInfo: UserEntity)
  func loadingAccountFailed()
}

class AccountInfoPresenter: AccountInfoPresenterInterface {
  var view : AccountInfoViewInterface!
  
  func display(accountInfo: UserEntity){
    
  }
  func loadingAccountFailed(){
    
  }
}
