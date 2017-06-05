//
//  BasicAuthenticationPlugin.swift
//  CarBid
//
//  Created by Dang Thai Son on 5/26/17.
//  Copyright © 2017 Khoi Truong Minh. All rights reserved.
//

import Foundation
import Moya
import Result

struct BasicAuthenticationPlugin: PluginType {
    let tokenStore: TokenKeychainStore

    init(tokenStore: TokenKeychainStore = TokenKeychainStore.default) {
        self.tokenStore = tokenStore
    }

    func willSend(_ request: RequestType, target: TargetType) {
        guard let target = target.rawTarget as? Authenticatable else { return  }
        guard target.authentication == .basic else { return }

        let authToken = tokenStore.getToken(type: target.authentication)
        guard authToken.isValid else { return }

        guard let username = authToken.username, let password = authToken.password else { return }
        let _ = request.authenticate(user: username, password: password, persistence: .none)

    }
}
