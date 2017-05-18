//
//  HTTPAuthProvider.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 5/18/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Moya
import Result
import Alamofire
import RxSwift

class HTTPAuthProvider : AuthProvider {
  lazy var provider : APIProvider = APIProvider(plugins: [CredentialsPlugin { _ in
    URLCredential(user: self.credential?.username ?? "",
                  password: self.credential?.password ?? "",
                  persistence: .none) }
    ] )
  
  public private(set) var credential : Credential?
  
  var authState : AuthState = .initial
  var queue: DispatchQueue = DispatchQueue(label: queueID, attributes: [])
  let loginTarget : APITargetType
  let logoutTarget : APITargetType
  
  init(loginTarget: APITargetType, logoutTarget: APITargetType){
    self.loginTarget = loginTarget
    self.logoutTarget = logoutTarget
  }
  
  fileprivate func advanceAuthState(_ nextState: AuthState) {
    func login() -> Observable<()> {
      return provider.request(MultiTarget(loginTarget)).retry(3).filterSuccessfulStatusCodes().map{ _ in () }
    }
    
    func logout() -> Observable<()> {
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
            self.authState = .noToken
          }, onError: { (_) in
            self.authState = .authenticated
            print("Logout unsuccessfully")
          }).addDisposableTo(DisposeBag())
        } else {
          print("Invalid nextState")
        }
      }
    }
    queue.async{ execute() }
  }
  
  // Function for setting credential in case of require credential input validation
  open func set(credential: Credential){
    self.credential = credential
  }
  
  open func login() {
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
  
  func logout() {
    if authState.canTransitionTo(.noToken) {
      advanceAuthState(.noToken)
    }
  }
}
