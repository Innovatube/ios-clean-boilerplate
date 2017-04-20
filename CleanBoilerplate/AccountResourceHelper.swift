//
//  AccountResourceHelper.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/23/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation
import RxSwift

class AccountResourceHelper {
  var persistentHelper = AccountDatabaseHelper()
  var networkHelper = AccountNetworkHelper()
  
  func login(email: String, password: String) -> Observable<UserEntity> {
    return Observable.create { observer in
      self.networkHelper.login(email: email, password: password).subscribe(onNext: { (entity) in
        self.persistentHelper.update(user: entity)
        observer.onNext(entity)
      }, onError: { (error) in
        observer.onError(error)
      })
    }
  }
  func logout() -> Observable<StatusEntity> {
    return networkHelper.logout()
  }
  func resetPassword(email: String) -> Observable<StatusEntity> {
    return networkHelper.resetPassword(email: email)
  }
  func accountInfo() -> Observable<UserEntity> {
    return Observable.create { observer in
      self.networkHelper.accountInfo().subscribe(onNext: { (entity) in
        self.persistentHelper.update(user: entity)
        observer.onNext(entity)
      }, onError: { (error) in
        observer.onError(error)
      })
    }
  }
}
