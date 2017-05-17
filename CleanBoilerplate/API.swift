//
//  API.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 5/17/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Alamofire
import Moya
import RxSwift

class API {
  
  static let provider = APIProvider()
  
  class func request(target: TargetType) -> Observable<Response> {
    return provider.request(MultiTarget(target))
  }
  
  class func requestWithProgress(target: TargetType) -> Observable<ProgressResponse> {
    return provider.requestWithProgress(MultiTarget(target))
  }
}

protocol APITargetType: TargetType {
  var isRequiredAuth : Bool { get }
}

extension APITargetType {
  
  var task: Task {
    return .request
  }
  
  var baseURL: URL {
    return URL(string: "{{basePath}}")!
  }
  
  var parameters: Parameters? {
    return nil
  }
  
  var parameterEncoding: CompositeEncoding {
    return CompositeEncoding()
  }
  
  var sampleData: Data {
    return Data()
  }
}

class APIProvider: RxMoyaProvider<MultiTarget> {
  
  override init(endpointClosure: @escaping EndpointClosure = APIProvider.endpointClosure,
                requestClosure: @escaping RequestClosure = MoyaProvider.defaultRequestMapping,
                stubClosure: @escaping StubClosure = MoyaProvider.neverStub,
                manager: Manager = RxMoyaProvider<MultiTarget>.defaultAlamofireManager(),
                plugins: [PluginType] = [],
                trackInflights: Bool = false) {
    
    super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins, trackInflights: trackInflights)
  }
  
  static func endpointClosure(_ target: MultiTarget) -> Endpoint<MultiTarget> {
    let endpoint = MoyaProvider<MultiTarget>.defaultEndpointMapping(for: target)
    
    guard let header = CompositeParameters(from: target.parameters)?.headerParameters else {
      return endpoint
    }
    return endpoint.adding(newHTTPHeaderFields: header)
  }
}
