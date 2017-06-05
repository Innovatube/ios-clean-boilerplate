//
//  OAuth2Plugin.swift
//  CarBid
//
//  Created by Dang Thai Son on 5/26/17.
//  Copyright © 2017 Khoi Truong Minh. All rights reserved.
//

import Foundation
import Moya

struct OAuth2Plugin: PluginType {
    let tokenStore: TokenKeychainStore

    init(tokenStore: TokenKeychainStore = TokenKeychainStore.default) {
        self.tokenStore = tokenStore
    }

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let target = target.rawTarget as? Authenticatable else { return request }
        guard target.authentication == .oauth2 else { return request }

        let authToken = tokenStore.getToken(type: target.authentication)
        guard authToken.isValid, let accessToken = authToken.accessToken, let tokenType = authToken.tokenType else { return request }

        var request = request
        request.addValue("\(tokenType) \(accessToken)", forHTTPHeaderField: "Authorization")

        return request
    }
}
