//
//  APIProvider.swift
//
//  Created by Dang Thai Son on 5/23/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import Alamofire
import Moya  

class APIProvider: RxMoyaProvider<MultiTarget> {

    override init(endpointClosure: @escaping EndpointClosure = APIProvider.endpointClosure,
         requestClosure: @escaping RequestClosure = MoyaProvider.defaultRequestMapping,
         stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
         manager: Manager = RxMoyaProvider<MultiTarget>.defaultAlamofireManager(),
         plugins: [PluginType] = [BasicAuthenticationPlugin(), JWTAccessTokenPlugin(), OAuth2Plugin()],
         trackInflights: Bool = false) {

        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }

    class func endpointClosure(_ target: MultiTarget) -> Endpoint<MultiTarget> {
        let endpoint = MoyaProvider<MultiTarget>.defaultEndpointMapping(for: target)

        guard let header = CompositeParameters(from: target.parameters)?.headerParameters else {
            return endpoint
        }
        return endpoint.adding(newHTTPHeaderFields: header)
    }
}

struct BasicAuthenticationPlugin: PluginType {

    func willSend(_ request: RequestType, target: TargetType) {
        guard let target = target as? Authenticatable else { return  }
        guard target.authentication == .http else { return }

        let authToken = TokenKeychainStore.shared.getToken(type: target.authentication)
        guard authToken.isValid else { return }

        guard let username = authToken.username, let password = authToken.password else { return }
        let urlCredential = URLCredential(user: username, password: password, persistence: .none)
        let _ = request.authenticate(usingCredential: urlCredential)
    }
}

struct JWTAccessTokenPlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let target = target as? Authenticatable else { return request }
        guard target.authentication == .accessToken else { return request }

        let authToken = TokenKeychainStore.shared.getToken(type: target.authentication)
        guard authToken.isValid, let accessToken = authToken.accessToken, let tokenType = authToken.tokenType else { return request }

        var request = request
        request.addValue("\(tokenType) \(accessToken)", forHTTPHeaderField: "Authorization")

        return request
    }
}

struct OAuth2Plugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let target = target as? Authenticatable else { return request }
        guard target.authentication == .accessToken else { return request }

        let authToken = TokenKeychainStore.shared.getToken(type: target.authentication)
        guard authToken.isValid, let accessToken = authToken.accessToken, let tokenType = authToken.tokenType else { return request }

        var request = request
        request.addValue("\(tokenType) \(accessToken)", forHTTPHeaderField: "Authorization")

        return request
    }
}

//let originalObservable = Observable.just("1")
//
//let defaultValueAfter5seconds = originalObservable.flatMapLatest { string in
//    return Observable<Int>.interval(5, scheduler: SerialDispatchQueueScheduler(qos: .background))
//        .map { _ in return "defaultValue" }
//}
//
//Observable.of(originalObservable, defaultValueAfter5seconds).merge()
//



