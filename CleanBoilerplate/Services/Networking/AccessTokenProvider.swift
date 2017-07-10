//
//  AccessTokenProvider.swift
//  CarBid
//
//  Created by Dang Thai Son on 5/31/17.
//  Copyright © 2017 Khoi Truong Minh. All rights reserved.
//

import Foundation
import RxSwift
import RxSwiftExt
import Moya

protocol AccessTokenProvider {
    var currentToken: Observable<AccessToken> { get }
}

class DefaultAccessTokenProvider: AccessTokenProvider {

    let currentToken: Observable<AccessToken>

    private let provider: RxMoyaProvider<MultiTarget>
    private let disposeBag: DisposeBag = DisposeBag()
    private let tokenStore: TokenKeychainStore

    init(provider: RxMoyaProvider<MultiTarget> = RxMoyaProvider<MultiTarget>(), tokenStore: TokenKeychainStore = TokenKeychainStore.default) {
        self.provider = provider
        self.tokenStore = tokenStore

        currentToken = tokenStore.observeToken().shareReplayLatestWhileConnected()

        let shouldRefreshToken = currentToken.flatMapLatest { $0.shouldRefreshTokenSoon.materialize() }

        let newToken = shouldRefreshToken
            .elements()
            .concatMap { [unowned self] in self.refreshAccessToken($0).materialize() }

        newToken
            .elements()
            .subscribe(onNext: { newToken in tokenStore.store(token: newToken) })
            .disposed(by: disposeBag)

        Observable
            .merge([shouldRefreshToken.errors(), newToken.errors()])
            .subscribe(onError: { error in
                // Log Error
                // print(error)
                tokenStore.clearToken()
            })
            .disposed(by: disposeBag)

    }
    
    func refreshAccessToken(_ refreshToken: String) -> Observable<AccessToken> {
//        let tokenTarget = AuthenticationTargets.RefreshTokenTarget(refreshToken: refreshToken)
//        return provider.request(MultiTarget(tokenTarget)).mapObject(AccessToken.self)
        return Observable.empty()
    }
}
