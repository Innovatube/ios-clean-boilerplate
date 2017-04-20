//
//  NavigationApplicationService.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/27/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import UIKit

class NavigationApplicationService {
  
  let router = MainRouter()
  private let window = UIWindow(frame: UIScreen.main.bounds)

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    // Override point for customization after application launch.
    window.rootViewController = router.navigationController
    window.makeKeyAndVisible()
    router.displayLoginView()
    return true
  }
}
