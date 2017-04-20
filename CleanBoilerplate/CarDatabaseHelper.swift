//
//  CarDatabaseHelper.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/22/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

class CarDatabaseHelper {
  var store : Realm!
  
  func getCars() -> Observable<[CarEntity]> {
    return Observable.array(from: store.objects(CarEntity.self))
  }
  
  func getCar(id:Int) -> Observable<CarEntity> {
    let objects = store.objects(CarEntity.self).filter{ $0.id == id }
    if let object = objects.first {
      return Observable.just(object)
    } else {
      return Observable.error(RealmObjectNotFoundError())
    }
  }
  
  func update(car: CarEntity) -> Observable<()> {
    return Observable.create { observer in
      self.store.add(car)
      observer.onNext(())
      return Disposables.create()
    }
  }
  
  func update(cars: [CarEntity]) -> Observable<()> {
    return Observable.create { observer in
      self.store.add(cars)
      observer.onNext(())
      return Disposables.create()
    }
  }
}
