//
//  FlareTargets.swift
//  CarBid
//
//  Created by Dang Thai Son on 5/23/17.
//  Copyright © 2017 Khoi Truong Minh. All rights reserved.
//

import Foundation
import Alamofire
import Moya

struct FlareTarget {
    struct Login: APITargetType {
        var baseURL: URL = URL(string: "http://flare-development.ap-southeast-1.elasticbeanstalk.com/api/v1")!
        var path: String = "token"
        var method = Moya.Method.post
        var task: Task = Task.request

        var parameterEncoding: ParameterEncoding = JSONEncoding()
        var parameters: Parameters? {

            var params = Parameters()
            params["username"] = "thanhnh1806@gmail.com"
            params["password"] = "123456"
            params["grant_type"] = "password"

            params["client_secret"] = "Y5WYu9BzLdHmtAGWZb7xEOwjZc6uQ9DTgYB7TK6f"
            params["client_id"] = 2

            return params
        }
    }
}
