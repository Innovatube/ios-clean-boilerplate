//
//  API.swift
//
//  Created by Dang Thai Son on 5/22/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import Moya
import RxSwift
import RxSwiftExt

class API {
    static let `default` = API()

    let provider: RxMoyaProvider<MultiTarget>
    let tokenProvider: AuthTokenProvider

    private let disposeBag: DisposeBag = DisposeBag()

    init(provider: RxMoyaProvider<MultiTarget> = APIProvider(), tokenProvider: AuthTokenProvider = AccessTokenProvider(authenticationType: .oauth2)) {
        self.provider = provider
        self.tokenProvider = tokenProvider
    }

    func authenticateRequest(target: APITargetType) -> Observable<Event<Response>> {
        guard target.authentication != .none else {
            return provider.request(MultiTarget(target)).materialize()
        }

        return tokenProvider
            .token
            .flatMap { [weak self] token -> Observable<Event<Response>> in
                guard token.isValid else {
                    let userInfo = [
                        NSLocalizedDescriptionKey: NSLocalizedString("Could not get authentication information!", comment: "Please sign in again."),
                        NSLocalizedFailureReasonErrorKey: NSLocalizedString("Not authorized.", comment: "Please sign in again.")
                    ]
                    let error = NSError(domain: AuthenticatioErrorDomain, code: 401, userInfo: userInfo)
                    return Observable.error(error).materialize()
                }
                guard let strongSelf = self else { return Observable.empty() }
                return strongSelf.provider.request(MultiTarget(target)).materialize()
            }
            .shareReplayLatestWhileConnected()
    }

    func requestWithProgress(target: APITargetType) -> Observable<ProgressResponse> {
        return provider.requestWithProgress(MultiTarget(target))
    }

    func request(target: APITargetType) -> Observable<Response> {
        return provider.request(MultiTarget(target))
    }
}

extension API {
    class func authenticateRequest(target: APITargetType) -> Observable<Event<Response>> {
        return `default`.authenticateRequest(target: target)
    }
}
