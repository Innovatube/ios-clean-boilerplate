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

private let usernameKey = "AuthUsername"
private let passwordKey = "AuthPassword"
private let tokenKey = "AccessToken"
private let tokenRefreshKey = "AccessTokenRefresh"
private let tokenTypeKey = "AccessTokenType"
private let expiryDateKey = "AccessTokenExpiryDate"

struct TokenKeychainStore {
    static let `default`: TokenKeychainStore = TokenKeychainStore()
    private let tokenSubject = PublishSubject<AccessToken>()
    private let keychain: Keychain

    init(keychain: Keychain = Keychain(service: Bundle.main.bundleIdentifier!)) {
        self.keychain = keychain
    }

    func store(token: AccessToken) {
        keychain[usernameKey] = token.username
        keychain[passwordKey] = token.password
        keychain[tokenKey] = token.accessToken
        keychain[tokenRefreshKey] = token.refreshToken
        keychain[tokenTypeKey] = token.tokenType
        keychain[expiryDateKey] = token.expiryDate?.string(format: .iso8601Auto)

        tokenSubject.onNext(token)
    }

    var currentToken: AccessToken {

        let username = keychain[usernameKey]
        let password = keychain[passwordKey]
        let accessToken = keychain[tokenKey]
        let tokenType = keychain[tokenTypeKey]
        let refreshToken = keychain[tokenRefreshKey]
        let expiryDate = keychain[expiryDateKey]?.date(format: .iso8601Auto)?.absoluteDate

        let token = AccessToken(username: username, password: password, accessToken: accessToken, tokenType: tokenType, refreshToken: refreshToken, expiryDate: expiryDate)
        return token
    }

    func clearToken() {
        keychain[usernameKey] = nil
        keychain[passwordKey] = nil
        keychain[tokenKey] = nil
        keychain[tokenRefreshKey] = nil
        keychain[tokenTypeKey] = nil
        keychain[expiryDateKey] = nil

        tokenSubject.onNext(AccessToken())
    }

    func observeToken() -> Observable<AccessToken> {
        return tokenSubject.startWith(currentToken)
    }
}
