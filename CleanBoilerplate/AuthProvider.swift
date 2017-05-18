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

class HTTPAuthProvider {
  static var shared = HTTPAuthProvider()
  lazy var provider : APIProvider = APIProvider(plugins: [CredentialsPlugin { _ in
    URLCredential(user: self.credential?.username ?? "",
                  password: self.credential?.password ?? "",
                  persistence: .none) }
    ] )
  
  public private(set) var credential : Credential?
  var token: AuthToken?
  
  var authState : AuthState = .initial
  var queue: DispatchQueue? = DispatchQueue(label: "com.tyson.AuthQueue", attributes: [])
  
  fileprivate func attemptAuthentication() {
    func execute(){
      
    }
    guard let queue = queue else { return }
    queue.async{ execute() }
  }
  
  fileprivate func resetToken(){
    token = nil
  }
  
  fileprivate func advanceAuthState(_ nextState: AuthState) {
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
          authState = nextState
          attemptAuthentication()
        } else {
          print("Invalid nextState")
        }
      case .authenticated:
        if nextState == .noToken {
          authState = nextState
          resetToken()
        } else {
          print("Invalid nextState")
        }
      }
    }
    guard let queue = queue else { return }
    queue.async{ execute() }
  }
  
  // Function for setting credential in case of require credential input validation
  open func set(credential: Credential){
    self.credential = credential
  }
  
  open func request(_ target: APITargetType) -> Observable<Response> {
    if authState.support(target: target) {
      return provider.request(MultiTarget(target))
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
