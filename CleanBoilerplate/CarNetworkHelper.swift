//
//  CarNetworkHelper.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/22/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

class CarNetworkHelper {
  func car(id: Int) -> Observable<CarEntity> {
    let route = "/cars/" + "\(id)"
    return json(.get, URL(string: domain + route)!)
      .flatMap{ (json) -> Observable<CarEntity> in
        if let statusEntity = json as? StatusEntity {
          return Observable.error(statusEntity)
        }
        guard let carEntity = json as? CarEntity else {
          return Observable.error(UnableToParseJSONError())
        }
        return Observable.just(carEntity)
    }
  }
  
  func cars(offset: Int, limit: Int) -> Observable<[CarEntity]> {
    let route = "/cars"
    return json(.get, URL(string: domain + route)!
      , parameters: ["offset":offset, "limit": limit])
    .flatMap{ json -> Observable<[CarEntity]> in
      guard let jsonDict = json as? [String:Any] else {
        return Observable.error(UnableToParseJSONError())
      }
      guard let cars = jsonDict["cars"] as? [CarEntity] else {
        return Observable.error(UnableToParseJSONError())
      }
      return Observable.just(cars)
    }
  }
  
  func carBid(id: Int, price: Int) -> Observable<CarEntity> {
    let route = "/cars/" + "\(id)" + "/bid"
    return json(.get, URL(string: domain + route)!, parameters: ["price":price])
    .flatMap{ (json) -> Observable<CarEntity> in
      if let statusEntity = json as? StatusEntity {
        return Observable.error(statusEntity)
      }
      guard let carEntity = json as? CarEntity else {
        return Observable.error(UnableToParseJSONError())
      }
      return Observable.just(carEntity)
    }
  }
}
