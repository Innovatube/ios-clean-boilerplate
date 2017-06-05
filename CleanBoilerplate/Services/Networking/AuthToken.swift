//
//  AuthToken.swift
//
//  Created by Dang Thai Son on 4/5/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftDate
import RxSwift

protocol Expirable {
    var expiryDate: Date? { get }

    /// If the token is going to expire in less than this, consider it expired and just get a new token
    var shouldExpireBefore: TimeInterval { get }
}

extension Expirable {
    var expired: Bool {
        if let expiryDate = expiryDate {
            return expiryDate < Date()
        }
        return true
    }

    var willExpireAt: TimeInterval {
        return expiryDate?.timeIntervalSinceNow ?? 0
    }

    var expiresSoon: Observable<Void> {
        let expiresSoonAt = willExpireAt - shouldExpireBefore

        guard expiresSoonAt > 0 else {
            return .just(()) // fire now if it expiresSoonAlready
        }

        return Observable<Int>.interval(expiresSoonAt, scheduler: MainScheduler.instance).map { _ in }
    }
}


public let AuthenticatioErrorDomain = "AuthenticatioErrorDomain"

struct AuthToken: Expirable {

    let username: String?
    let password: String?
    let accessToken: String?
    let tokenType: String?
    let refreshToken: String?
    let expiryDate: Date?

    var shouldExpireBefore: TimeInterval { return 60 }

    // MARK: - Initializers
    init() {
        self.username = nil
        self.password = nil
        self.accessToken = nil
        self.tokenType = nil
        self.refreshToken = nil
        self.expiryDate = Date()
    }
    
    init(username: String?, password: String?, accessToken: String?, tokenType: String?, refreshToken: String?, expiryDate: Date?) {
        self.username = username
        self.password = password
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.refreshToken = refreshToken
        self.expiryDate = expiryDate
    }

    var isValid: Bool {

        if let accessToken = accessToken {
            return accessToken.isNotEmpty && !expired
        }

        return false
    }

    var shouldRefreshTokenSoon: Observable<String> {
        let userInfo = [
            NSLocalizedDescriptionKey: NSLocalizedString("Access token is invalid", comment: ""),
            NSLocalizedFailureReasonErrorKey: NSLocalizedString("Access token expired, no refresh token available.", comment: ""),
            ]
        let error = NSError(domain: AuthenticatioErrorDomain, code: 401, userInfo: userInfo)
        return expiresSoon.map { _ in self.refreshToken }.errorOnNil(error)
    }
}

extension AuthToken: ImmutableMappable {

    init(map: Map) throws {
        username = nil
        password = nil

        accessToken = try map.value("access_token")
        tokenType = try map.value("token_type")
        refreshToken = try map.value("refresh_token")
        expiryDate = try map.value("expires_in")
    }
}
