//
//  AuthProvider.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 5/17/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Moya
import Result
import Alamofire
import RxSwift

enum AuthMode {
  case http
  case jwt
  case oAuth
}

struct AuthError : Swift.Error {
  let message : String
}

class AuthProvider {
  static var shared = AuthProvider()
  var authMode : AuthMode = .http
  var authState : AuthState = .initial
  var queue: DispatchQueue? = DispatchQueue(label: "com.tyson.AuthQueue", attributes: [])
  
  fileprivate func attemptAuthentication() {
    func execute(){
      
    }
    guard let queue = queue else { return }
    queue.async{ execute() }
  }
  
  fileprivate func advanceAuthState(_ nextState: AuthState) {
    func execute(){
      
    }
    guard let queue = queue else { return }
    queue.async{ execute() }
  }
  
  open func request(_ target: APITargetType) -> Observable<Response> {
    if authState.support(target: target) {
      return API.request(target: target)
    } else {
      return Observable.error(AuthError(message:"Couldn't request \(target) due to wrong authState"))
    }
  }
  
  func logOut() {
    if authState.canTransitionTo(.noToken) {
      advanceAuthState(.noToken)
    }
  }
}
