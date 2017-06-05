//
//  AccessTokenProvider.swift
//  CarBid
//
//  Created by Dang Thai Son on 5/31/17.
//  Copyright © 2017 Khoi Truong Minh. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol AuthTokenProvider {
    var token: Observable<AuthToken> { get }
}

class AccessTokenProvider: AuthTokenProvider {

    let token: Observable<AuthToken>

    private let provider: RxMoyaProvider<MultiTarget>
    private let disposeBag: DisposeBag = DisposeBag()
    private let tokenStore: TokenKeychainStore

    init(provider: RxMoyaProvider<MultiTarget> = RxMoyaProvider<MultiTarget>(), tokenStore: TokenKeychainStore = TokenKeychainStore.default, authenticationType: Authentication) {
        self.provider = provider
        self.tokenStore = tokenStore

        token = tokenStore.observeToken(type: authenticationType).shareReplayLatestWhileConnected()

        let newToken = token
            // TODO: Retry when cannot connect to server
            .flatMapLatest { $0.shouldRefreshTokenSoon }
            .concatMap { [unowned self] in self.refreshAccessToken($0) }
            .materialize()

        newToken
            .elements()
            .subscribe(onNext: { newToken in
                tokenStore.store(token: newToken, type: authenticationType)
            })
            .disposed(by: disposeBag)

        newToken
            .errors()
            .subscribe(onError: { error in
                // Log Error
                // print(error)
                tokenStore.clearToken(type: authenticationType)
            })
            .disposed(by: disposeBag)
    }

    func refreshAccessToken(_ refreshToken: String) -> Observable<AuthToken> {
//        let authenticateTarget = FlareTarget.Login()
//        return provider.request(MultiTarget(authenticateTarget)).mapObject(AuthToken.self)
        return Observable.empty()
    }
    
}
