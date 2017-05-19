//
//  AuthProvider.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 5/17/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Moya
import Alamofire
import RxSwift

struct AuthError : Swift.Error {
  let message : String
}

extension AuthProvider {
  static var queueID : String { return "com.tyson.AuthQueue" }
}

class AuthProvider {
  //Should be override by subclass
  var provider : APIProvider { return APIProvider() }
  var authState : AuthState = .initial
  var queue: DispatchQueue = DispatchQueue(label: queueID, attributes: [])
  var loginTarget : APITargetType?
  var logoutTarget : APITargetType?
  
  internal func advanceAuthState(_ nextState: AuthState) {
    func login() -> Observable<()> {
      guard let loginTarget = loginTarget else { return Observable.error(AuthError(message: "Missing login target")) }
      return provider.request(MultiTarget(loginTarget)).retry(3).filterSuccessfulStatusCodes().map{ _ in () }
    }
    
    func logout() -> Observable<()> {
      guard let logoutTarget = logoutTarget else  { return Observable.error(AuthError(message: "Missing logout target")) }
      return provider.request(MultiTarget(logoutTarget)).retry(3).filterSuccessfulStatusCodes().map{ _ in () }
    }
    
    func execute(){
      switch authState {
      case .initial:
        if nextState == .noToken {
          authState = nextState
        } else {
          print("Invalid nextState")
        }
      case .noToken:
        if nextState == .authenticated {
          login().subscribe(onNext: { _ in
            self.authState = nextState
          }, onError: { (_) in
            self.authState = .noToken
            print("Login unsuccessfully")
          }).addDisposableTo(DisposeBag())
        } else {
          print("Invalid nextState")
        }
      case .authenticated:
        if nextState == .noToken {
          logout().subscribe(onNext: { _ in
            self.authState = nextState
          }, onError: { (_) in
            self.authState = .authenticated
            print("Login unsuccessfully")
          }).addDisposableTo(DisposeBag())
        } else {
          print("Invalid nextState")
        }
      }
    }
    queue.async{ execute() }
  }
  
  open func login(target: APITargetType) {
    self.loginTarget = target
    if authState.canTransitionTo(.authenticated){
      advanceAuthState(.authenticated)
    }
  }
  
  open func request(_ target: APITargetType) -> Observable<Response> {
    if authState.support(target: target) {
      return provider.request(MultiTarget(target))
    } else {
      return Observable.error(AuthError(message:"Couldn't request \(target) due to invalid authState"))
    }
  }
  
  func logout(target: APITargetType) {
    self.logoutTarget = target
    if authState.canTransitionTo(.noToken) {
      advanceAuthState(.noToken)
    }
  }

}
