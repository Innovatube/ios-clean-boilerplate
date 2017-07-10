//
//  APIProvider.swift
//
//  Created by Dang Thai Son on 5/23/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import Alamofire
import Moya
import RxSwift

extension TargetType {

    var rawTarget: TargetType {

        if let multiTarget = self as? MultiTarget {
            return multiTarget.target
        }
        return self
    }
}

class APIProvider: RxMoyaProvider<MultiTarget> {

    override init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
         requestClosure: @escaping RequestClosure = MoyaProvider.defaultRequestMapping,
         stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
         manager: Manager = RxMoyaProvider<MultiTarget>.defaultAlamofireManager(),
         plugins: [PluginType] = [JWTPlugin(), NetworkErrorTransformPlugin(), NetworkErrorLogger()],
         trackInflights: Bool = false) {

        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }
}





