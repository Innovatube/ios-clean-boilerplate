//
//  AccountNetworkHelper.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/22/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation
import RxSwift
import RxAlamofire
import Alamofire

let domain = "https://www.example.com"

class AccountNetworkHelper {
  
  func login(email: String, password: String) -> Observable<UserEntity> {
    let route = "/signIn"
    return json(.post , URL(string: domain + route)!, parameters: ["email":email, "password": password])
    .flatMap{ (json) -> Observable<UserEntity> in
      if let statusEntity = json as? StatusEntity {
        return Observable.error(statusEntity)
      }
      guard let userEntity = json as? UserEntity else {
        return Observable.error(UnableToParseJSONError())
      }
      return Observable.just(userEntity)
    }
  }
  
  func logout() -> Observable<StatusEntity> {
    let route = "/signOut"
    return json(.post, URL(string: domain + route)!)
      .flatMap{ json -> Observable<StatusEntity> in
        guard let statusEntity = json as? StatusEntity else {
          return Observable.error(UnableToParseJSONError())
        }
        guard statusEntity.isSuccess else {
          return Observable.error(statusEntity)
        }
        return Observable.just(statusEntity)
    }
  }
  
  func resetPassword(email: String) -> Observable<StatusEntity> {
    let route = "/reset-password"
    return json(.get, URL(string: domain + route)!, parameters: ["email":email])
      .flatMap{ json -> Observable<StatusEntity> in
        guard let statusEntity = json as? StatusEntity else {
          return Observable.error(UnableToParseJSONError())
        }
        guard statusEntity.isSuccess else {
          return Observable.error(statusEntity)
        }
        return Observable.just(statusEntity)
    }
  }
  
  func accountInfo() -> Observable<UserEntity> {
    let route = "/me"
    return json(.get, URL(string: domain + route)!)
      .flatMap{ (json) -> Observable<UserEntity> in
        if let statusEntity = json as? StatusEntity {
          return Observable.error(statusEntity)
        }
        guard let userEntity = json as? UserEntity else {
          return Observable.error(UnableToParseJSONError())
        }
        return Observable.just(userEntity)
    }
  }
  
}
