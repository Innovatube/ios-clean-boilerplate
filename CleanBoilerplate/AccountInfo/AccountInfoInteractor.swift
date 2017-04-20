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
  var resourceHelper : AccountResourceHelper!
  
  func requestAccountInfo() {
    resourceHelper.accountInfo().subscribe(onNext: { (entity) in
      self.presenter.display(accountInfo: entity)
    }) { (_) in
      self.presenter.loadingAccountFailed()
    }
  }
  
}
