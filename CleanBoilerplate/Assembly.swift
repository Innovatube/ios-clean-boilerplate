//
//  Assembly.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/27/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation

class Assembly {
  class func facebookApplicationService() -> FacebookApplicationService {
    return FacebookApplicationService()
  }
  
  class func googleSignInApplicationService() -> GoogleApplicationService {
    return GoogleApplicationService()
  }
  
  class func navigationApplicationService() -> NavigationApplicationService {
    return NavigationApplicationService()
  }
}
