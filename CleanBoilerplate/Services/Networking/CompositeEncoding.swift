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
    public var header: [String: String]? = nil
    public var body: Parameters? = nil
    public var form: Parameters? = nil
    public var query: Parameters? = nil
}

private let CompositeParametersKey = "CompositeParameters"
public extension CompositeParameters {

    func toParameters() -> Parameters {
        return [CompositeParametersKey: self]
    }

    static func from(_ parameters: Parameters?) -> CompositeParameters? {
        return parameters?[CompositeParametersKey] as? CompositeParameters
    }
}

public struct CompositeEncoding: ParameterEncoding {

    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        guard let parameters = CompositeParameters.from(parameters) else {
            return try urlRequest.asURLRequest()
        }
        var compositeRequest = try urlRequest.asURLRequest()

        if let body = parameters.body {
            compositeRequest = try JSONEncoding.default.encode(urlRequest, with: body)
        } else if let form = parameters.form {
            compositeRequest = try URLEncoding.default.encode(urlRequest, with: form)
        }

        // Add Query Parameter
        if let queryParamters = parameters.query {
            let queryRequest = try URLEncoding.queryString.encode(urlRequest, with: queryParamters)
            compositeRequest.url = queryRequest.url
        }

        // Header Parameter
        parameters.header?.forEach { key , value in
            compositeRequest.addValue(value, forHTTPHeaderField: key)
        }

        return compositeRequest
    }
}


