//
//  TokenKeychainStore.swift
//
//  Created by Dang Thai Son on 5/19/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import Foundation
import SwiftDate
import KeychainAccess

private let appName: String = (Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String) ?? "AppName"

private let AuthUsername = "\(appName)AuthUsername"
private let AuthPassword = "\(appName)AuthPassword"
private let AuthTokenKey = "\(appName)AuthToken"
private let AuthTokenRefresh = "\(appName)AuthTokenRefresh"
private let AuthTokenType = "\(appName)AuthTokenType"
private let AuthTokenExpiryDate = "\(appName)AuthTokenExpiryDate"

extension Authentication {
    // Keychain key
    var usernameKey: String {
        return self.rawValue + AuthUsername
    }

    var passwordKey: String {
        return self.rawValue + AuthUsername
    }

    var tokenKey: String {
        return self.rawValue + AuthTokenKey
    }

    var tokenRefreshKey: String {
        return self.rawValue + AuthTokenRefresh
    }

    var tokenTypeKey: String {
        return self.rawValue + AuthTokenType
    }

    var expiryDateKey: String {
        return self.rawValue + AuthTokenExpiryDate
    }
}

struct TokenKeychainStore {
    static let shared: TokenKeychainStore = TokenKeychainStore()
    var keychain: Keychain

    init() {
        keychain = Keychain(service: Bundle.main.bundleIdentifier!)
    }

    func store(token: AuthToken, type: Authentication) {
        keychain[type.usernameKey] = token.username
        keychain[type.passwordKey] = token.password
        keychain[type.tokenKey] = token.accessToken
        keychain[type.tokenRefreshKey] = token.refreshToken
        keychain[type.tokenTypeKey] = token.tokenType
        keychain[type.expiryDateKey] = token.expiryDate?.string(format: .iso8601Auto)
    }

    func getToken(type: Authentication) -> AuthToken  {

        let username = keychain[type.usernameKey]
        let password = keychain[type.passwordKey]
        let accessToken = keychain[type.tokenKey]
        let tokenType = keychain[type.tokenTypeKey]
        let refreshToken = keychain[type.tokenRefreshKey]
        let expiryDate = keychain[type.expiryDateKey]?.date(format: .iso8601Auto)?.absoluteDate

        let authToken = AuthToken(username: username, password: password, accessToken: accessToken, tokenType: tokenType, refreshToken: refreshToken, expiryDate: expiryDate)
        return authToken
    }

    func clearToken(type: Authentication) {
        keychain[type.usernameKey] = nil
        keychain[type.passwordKey] = nil
        keychain[type.tokenKey] = nil
        keychain[type.tokenRefreshKey] = nil
        keychain[type.tokenTypeKey] = nil
        keychain[type.expiryDateKey] = nil
    }
}
