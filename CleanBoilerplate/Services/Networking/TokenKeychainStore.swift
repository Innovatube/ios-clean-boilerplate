//
//  TokenKeychainStore.swift
//
//  Created by Dang Thai Son on 5/19/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import Foundation
import SwiftDate
import KeychainAccess
import RxSwift

private let appName: String = (Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String) ?? "AppName"

private let AuthUsername = "AuthUsername"
private let AuthPassword = "AuthPassword"
private let AuthTokenKey = "AuthToken"
private let AuthTokenRefresh = "AuthTokenRefresh"
private let AuthTokenType = "AuthTokenType"
private let AuthTokenExpiryDate = "AuthTokenExpiryDate"

extension Authentication {
    // Keychain key
    var usernameKey: String {
        return appName
            .appending(".")
            .appending(self.rawValue)
            .appending(AuthUsername)
    }

    var passwordKey: String { return "\(appName).\(self.rawValue).\(AuthPassword)" }

    var tokenKey: String { return "\(appName).\(self.rawValue).\(AuthTokenKey)" }

    var tokenRefreshKey: String { return "\(appName).\(self.rawValue).\(AuthTokenRefresh)" }

    var tokenTypeKey: String { return "\(appName).\(self.rawValue).\(AuthTokenType)" }

    var expiryDateKey: String { return "\(appName).\(self.rawValue).\(AuthTokenExpiryDate)" }
}

struct TokenKeychainStore {
    static let `default`: TokenKeychainStore = TokenKeychainStore()

    typealias TokenData = (token: AuthToken, type: Authentication)
    private let tokenSubject = PublishSubject<TokenData>()
    private let keychain: Keychain

    init(keychain: Keychain = Keychain(service: Bundle.main.bundleIdentifier!)) {
        self.keychain = keychain
    }

    func store(token: AuthToken, type: Authentication) {
        keychain[type.usernameKey] = token.username
        keychain[type.passwordKey] = token.password
        keychain[type.tokenKey] = token.accessToken
        keychain[type.tokenRefreshKey] = token.refreshToken
        keychain[type.tokenTypeKey] = token.tokenType
        keychain[type.expiryDateKey] = token.expiryDate?.string(format: .iso8601Auto)

        tokenSubject.onNext(TokenData(token: token, type: type))
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

        tokenSubject.onNext(TokenData(token: AuthToken(), type: type))
    }

    func observeToken(type: Authentication) -> Observable<AuthToken> {
        let currentToken = getToken(type: type)
        return tokenSubject
            .filter { $0.type == type }
            .map { token, _ in return token }
            .startWith(currentToken)
    }
}
