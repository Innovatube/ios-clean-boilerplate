//
//  CarResourceHelper.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/23/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation
import RxSwift

class CarResourceHelper {
  var networkHelper = CarNetworkHelper()
  var persistentHelper = CarDatabaseHelper()
  
  func car(id:Int) -> Observable<CarEntity> {
    return Observable.create { observer in
    self.persistentHelper.getCar(id: id).subscribe(onNext: { (entity) in
      observer.onNext(entity)
    }) { (_) in
      self.networkHelper.car(id: id).subscribe(onNext: { (entity) in
        self.persistentHelper.update(car: entity)
        observer.onNext(entity)
      }, onError: { (error) in
        observer.onError(error)
      })
    }
  }
  }
  
  func cars() -> Observable<[CarEntity]> {
    return Observable.create { observer in
      self.persistentHelper.getCars().subscribe(onNext: { (entities) in
        observer.onNext(entities)
      }, onError: { (_) in
        self.networkHelper.cars(offset: 1, limit: 10).subscribe(onNext: { (entities) in
          self.persistentHelper.update(cars: entities)
          observer.onNext(entities)
        }, onError: { (error) in
          observer.onError(error)
        })
      })
    }
  }
  
  func carBid(id:Int, price: Int) -> Observable<CarEntity> {
    return Observable.create { observer in
      self.networkHelper.car(id: id).subscribe(onNext: { (entity) in
        self.persistentHelper.update(car: entity)
        observer.onNext(entity)
      }, onError: { (error) in
        observer.onError(error)
      })
    }
  }
  
}
