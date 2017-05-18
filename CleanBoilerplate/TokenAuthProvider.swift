//
//  TokenAuthProvider.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 5/18/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Moya
import Result
import Alamofire
import RxSwift

class TokenAuthProvider : AuthProvider {
  
  override var provider : APIProvider {
    if _provider == nil {
      _provider = providerFactory()
    }
    guard let _provider = _provider else { fatalError("Missing provider object") }
    return _provider
  }
  private var _provider : APIProvider?
  private var token : AuthToken?
  
  fileprivate func providerFactory() -> APIProvider {
    guard let token = token?.token else { return APIProvider() }
    return APIProvider(plugins: [AccessTokenPlugin(token: token)])
  }
  
}
