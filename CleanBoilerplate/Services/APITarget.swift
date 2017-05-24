//
//  APITarget.swift
//
//  Created by Dang Thai Son on 5/22/17.
//  Copyright © 2017 Innovatube. All rights reserved.
//

import Alamofire
import Moya

protocol Authenticatable {
    var authentication: Authentication { get }
}

enum Authentication: String {
    case none
    case http
    case accessToken
    case oauth2
}

protocol APITargetType: TargetType, Authenticatable {}

extension APITargetType {

    var task: Task {
        return .request
    }

    var baseURL: URL {
        return URL(string: "")!
    }

    var authentication: Authentication {
        return .none
    }

    var parameters: Parameters? {
        return nil
    }

    var parameterEncoding: ParameterEncoding {
        return CompositeEncoding()
    }

    var sampleData: Data {
        return Data()
    }
}
