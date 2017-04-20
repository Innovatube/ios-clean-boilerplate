//
//  GoogleApplicationService.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/27/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation
import Google
import GoogleSignIn

/*
 - ```pod 'Google/SignIn'```
 - pod update
 - Go to https://developers.google.com/mobile/add?platform=ios&cntapi=signin&cntapp=Default%20Demo%20App&cntpkg=com.google.samples.quickstart.SignInExample to get the googleService-Info.plist file. Remember to change to the correct bundleIdentifier of current project.
 - Add a new URL scheme by 
 ```
 <dict>
 <key>CFBundleTypeRole</key>
 <string>Editor</string>
 <key>CFBundleURLSchemes</key>
 <array>
 <string>com.googleusercontent.apps.542864855212-ihmejp17kngkk8p99db2javllb1m2gbh</string>
 </array>
 </dict>
 ```
 within the CFBundleURLTypes value inside info.plist
 - Add 
 ```
 GIDSignIn.sharedInstance().signIn()
 ```
 for sign in
 
 */


class GoogleApplicationService :NSObject,  GIDSignInDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    var configureError: NSError?
    GGLContext.sharedInstance().configureWithError(&configureError)
    assert(configureError == nil, "Error configuring Google services: \(configureError)")
    
    GIDSignIn.sharedInstance().delegate = self
    return true
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    return GIDSignIn.sharedInstance().handle(url as URL!,
                                         sourceApplication: options[ UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                         annotation: options[UIApplicationOpenURLOptionsKey.annotation])
  }
  
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
  }
  
  func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
  }
  
}
