//
//  FacebookApplicationService.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/27/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation
import FBSDKLoginKit
import FBSDKCoreKit

/*
 - ```pod 'FBSDKCoreKit'
 pod 'FBSDKLoginKit'```
 - pod update
 - Adding
 ```<key>LSApplicationQueriesSchemes</key>
 <array>
 <string>fbapi</string>
 <string>fb-messenger-api</string>
 <string>fbauth2</string>
 <string>fbshareextension</string>
 </array>
 ``` into .plist
 - Retrieving the code for the facebookAppID etc. Add it along with a new URL scheme. Don't overwrite the Google's URL scheme if you added it first.
 - Go to facebook developer setting to register bundleIdentifier
 - Add this code in order to login
 ```FBSDKLoginManager().logIn(withReadPermissions: ["public_profile"], from: self) { (_, _) in
 }```
 
 */


class FacebookApplicationService {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, options: options)
  }
}
