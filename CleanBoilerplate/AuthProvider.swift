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

protocol AuthProvider {
  var loginTarget : APITargetType { get }
  var logoutTarget : APITargetType { get }
  var authState : AuthState { get set }
  
  func login()
  func logout()
  func request(_ target: APITargetType) -> Observable<Response>
}

extension AuthProvider {
  static var queueID : String { return "com.tyson.AuthQueue" }
}
