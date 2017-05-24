//
//  AuthToken.swift
//
//  Created by Dang Thai Son on 4/5/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import Foundation

struct AuthToken {

    let username: String?
    let password: String?
    let accessToken: String?
    let tokenType: String?
    let refreshToken: String?
    let expiryDate: Date?

    // MARK: - Initializers
    init(username: String?, password: String?, accessToken: String?, tokenType: String?, refreshToken: String?, expiryDate: Date?) {
        self.username = username
        self.password = password
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.refreshToken = refreshToken
        self.expiryDate = expiryDate
    }

    // MARK: - Properties
    var expired: Bool {
        if let expiryDate = expiryDate {
           return expiryDate > Date()
        }
        return true
    }

    var isValid: Bool {
        if let accessToken = accessToken {
            return accessToken.isNotEmpty && !expired
        }

        return false
    }
}
