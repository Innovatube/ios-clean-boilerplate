//
//  BasicAuthenticationPlugin.swift
//  CarBid
//
//  Created by Dang Thai Son on 5/26/17.
//  Copyright © 2017 Khoi Truong Minh. All rights reserved.
//

import Foundation
import Moya

struct BasicAuthenticationPlugin: PluginType {
    let tokenStore: TokenKeychainStore

    init(tokenStore: TokenKeychainStore = TokenKeychainStore.default) {
        self.tokenStore = tokenStore
    }

    func willSend(_ request: RequestType, target: TargetType) {
        guard let target = target.rawTarget as? Authenticatable else { return  }
        guard target.authentication == .basic else { return }

        let token = tokenStore.currentToken
        guard token.isValid else { return }

        guard let username = token.username, let password = token.password else { return }
        let _ = request.authenticate(user: username, password: password, persistence: .none)
    }
}
