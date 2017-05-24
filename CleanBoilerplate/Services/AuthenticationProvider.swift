//
//  AuthenticateProvider.swift
//
//  Created by Dang Thai Son on 5/23/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class AuthenticationProvider {
    // TODO: Reconsider using class func & static variable
    static let provider = APIProvider()

    private static let tokenKeychainStore = TokenKeychainStore()
    private let accessToken: Observable<AuthToken>
    private let publishSubject = PublishSubject<Authenticatable>()

    init() {
        accessToken = publishSubject
            .asObservable()
            .concatMap { target -> Observable<AuthToken> in
                return AuthenticationProvider.requestAccessTokenIfNeed(type: target.authentication)
            }
            .shareReplayLatestWhileConnected()
    }

    private class func requestAccessTokenIfNeed(type: Authentication) -> Observable<AuthToken> {
        // TODO: Handle Basic HTTP Authentication with User Credential
        guard type != .none else { return Observable.empty() }

        let token = tokenKeychainStore.getToken(type: type)
        guard !token.isValid else { return Observable<AuthToken>.just(token) }

        guard let refreshToken = token.refreshToken else {
            let userInfo = [
                NSLocalizedDescriptionKey: NSLocalizedString("Access token is invalid", comment: ""),
                NSLocalizedFailureReasonErrorKey: NSLocalizedString("Access token expired, no refresh token available.", comment: ""),
                ]
            let error = NSError(domain: "", code: 401, userInfo: userInfo)
            return Observable.error(error)
        }

        if type == .oauth2 {
            return refreshOAuthAccessToken(refreshToken).do(onNext: { saveToken($0, type: type) })
        }

        return refreshJWTAccessToken(refreshToken).do(onNext: { saveToken($0, type: type) })
    }

    func getAccesToken(for target: Authenticatable) -> Observable<AuthToken> {
        publishSubject.onNext(target)
        return accessToken
    }

    class func refreshJWTAccessToken(_ refreshToken: String) -> Observable<AuthToken> {
        // let authenticateTarget = FlareTarget.Login()
        // return provider.request(MultiTarget(authenticateTarget))

        return Observable.empty()
    }

    class func refreshOAuthAccessToken(_ refreshToken: String) -> Observable<AuthToken> {
        // let authenticateTarget = FlareTarget.Login()
        // return provider.request(MultiTarget(authenticateTarget))
        return Observable.empty()
    }

    class func saveToken(_ token: AuthToken, type: Authentication) {
        tokenKeychainStore.store(token: token, type: type)
    }
}
