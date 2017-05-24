//
//  API.swift
//
//  Created by Dang Thai Son on 5/22/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class API {
    static let provider = APIProvider()
    static let authenticationProvider = AuthenticationProvider()

    class func request(target: APITargetType) -> Observable<Response> {
        guard target.authentication != .none else {
            return provider.request(MultiTarget(target))
        }

        let response = authenticationProvider
            .getAccesToken(for: target)
            .flatMap { _ in return provider.request(MultiTarget(target)) }

        return response
    }

    class func requestWithProgress(target: APITargetType) -> Observable<ProgressResponse> {
        return provider.requestWithProgress(MultiTarget(target))
    }
}
