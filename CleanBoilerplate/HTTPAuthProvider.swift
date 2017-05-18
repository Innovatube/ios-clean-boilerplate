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
  
  public private(set) var credential : Credential?
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
    guard let credential = credential else { return APIProvider() }
    return APIProvider(plugins: [CredentialsPlugin { _ in
      URLCredential(user: credential.username,
                    password: credential.password,
                    persistence: .none) }
      ] )
  }
  
  // Function for setting credential in case of require credential input validation
  open func set(credential: Credential){
    self.credential = credential
  }
}
