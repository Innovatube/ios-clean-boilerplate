//
//  CompositeEncoding.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 5/17/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation
import Alamofire

public struct CompositeParameters {
  public var bodyParameters: Parameters? = nil
  public var formParameters: Parameters? = nil
  public var queryParameters: Parameters? = nil
  public var headerParameters: [String: String]? = nil
}

public extension CompositeParameters {
  
  func toParameters() -> Parameters {
    return ["compositeParameters": self]
  }
  
  init?(from parameters: Parameters?) {
    guard let compositeParameters = parameters?["compositeParameters"] as? CompositeParameters else {
      return nil
    }
    bodyParameters = compositeParameters.bodyParameters
    formParameters = compositeParameters.formParameters
    queryParameters = compositeParameters.queryParameters
    headerParameters = compositeParameters.headerParameters
  }
}

public struct CompositeEncoding: ParameterEncoding {
  
  public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
    guard let parameters = CompositeParameters(from: parameters) else {
      return try urlRequest.asURLRequest()
    }
    var compositeRequest = try urlRequest.asURLRequest()
    
    if let bodyParameters = parameters.bodyParameters {
      compositeRequest = try JSONEncoding.default.encode(urlRequest, with: bodyParameters)
    } else if let formParameters = parameters.formParameters {
      compositeRequest = try URLEncoding.default.encode(urlRequest, with: formParameters)
    }
    
    if let queryParamters = parameters.queryParameters {
      let queryRequest = try URLEncoding.queryString.encode(urlRequest, with: queryParamters)
      compositeRequest.url = queryRequest.url
    }
    
    return compositeRequest
  }
}
