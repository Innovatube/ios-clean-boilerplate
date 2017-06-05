//
//  CompositeEncoding.swift
//
//  Created by Dang Thai Son on 3/28/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import Foundation
import Alamofire
import Moya

public struct CompositeParameters {
    public var headerParameters: [String: String]? = nil
    public var bodyParameters: Parameters? = nil
    public var formParameters: Parameters? = nil
    public var queryParameters: Parameters? = nil
}

public struct CompositeEncoding: ParameterEncoding {

    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        guard let parameters = CompositeParameters.from(parameters) else {
            return try urlRequest.asURLRequest()
        }
        var compositeRequest = try urlRequest.asURLRequest()

        if let bodyParameters = parameters.bodyParameters {
            compositeRequest = try JSONEncoding.default.encode(urlRequest, with: bodyParameters)
        } else if let formParameters = parameters.formParameters {
            compositeRequest = try URLEncoding.default.encode(urlRequest, with: formParameters)
        }

        // Add Query Parameter
        if let queryParamters = parameters.queryParameters {
            let queryRequest = try URLEncoding.queryString.encode(urlRequest, with: queryParamters)
            compositeRequest.url = queryRequest.url
        }

        // Header Parameter
        parameters.headerParameters?.forEach { key , value in
            compositeRequest.addValue(value, forHTTPHeaderField: key)
        }

        return compositeRequest
    }
}

private let CompositeParametersKey = "CompositeParameters"

public extension CompositeParameters {

    func toMoyaParameters() -> Parameters {
        return [CompositeParametersKey: self]
    }

    static func from(_ parameters: Parameters?) -> CompositeParameters? {
        return parameters?[CompositeParametersKey] as? CompositeParameters
    }
}
