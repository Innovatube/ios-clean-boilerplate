//
//  AccountDatabaseHelper.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/22/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation
import RxRealm
import RxSwift
import RealmSwift

class AccountDatabaseHelper {
  var store: Realm!
  
  func getUser() -> Observable<UserEntity> {
    return Observable.just(store.objects(UserEntity.self).first!)
  }
  
  func update(user: UserEntity) -> Observable<()> {
    return Observable.create { observer in
      self.store.add(user)
      observer.onNext(())
      return Disposables.create()
    }
  }
}
