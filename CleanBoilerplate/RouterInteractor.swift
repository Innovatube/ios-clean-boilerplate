//
//  RouterInteractor.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/22/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation

protocol RouterInteractorInterface {
  func routeToSettingView()
}

class RouterInteractor: RouterInteractorInterface {
  var router: MainRouter!
  
  func routeToSettingView() {
    router.displaySettingView()
  }
}
