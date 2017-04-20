//
//  AppDelegate.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/16/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  let googleService = Assembly.googleSignInApplicationService()
  let navigationService = Assembly.navigationApplicationService()
  let facebookService = Assembly.facebookApplicationService()

  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    _ = googleService.application(application, didFinishLaunchingWithOptions: launchOptions)
      _ = navigationService.application(application, didFinishLaunchingWithOptions: launchOptions)
    _ = facebookService.application(application, didFinishLaunchingWithOptions: launchOptions)
    return true
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    _ = googleService.application(app, open: url, options: options)
    _ = facebookService.application(app, open: url, options: options)
    return true
  }
}

