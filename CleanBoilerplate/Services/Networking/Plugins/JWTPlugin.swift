//
//  JWTPlugin.swift
//  CarBid
//
//  Created by Dang Thai Son on 5/26/17.
//  Copyright © 2017 Khoi Truong Minh. All rights reserved.
//

import Foundation
import Moya

struct JWTPlugin: PluginType {
    let tokenStore: TokenKeychainStore

    init(tokenStore: TokenKeychainStore = TokenKeychainStore.default) {
        self.tokenStore = tokenStore
    }

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let target = target.rawTarget as? Authenticatable else { return request }
        guard target.authentication == .accessToken || target.authentication == .oauth2 else { return request }

        let token = tokenStore.currentToken
        guard token.isValid, let accessToken = token.accessToken, let tokenType = token.tokenType else { return request }

        var request = request
        request.addValue("\(tokenType) \(accessToken)", forHTTPHeaderField: "Authorization")

        return request
    }
}
