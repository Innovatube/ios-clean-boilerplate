//
//  AuthState.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 5/17/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation

enum AuthState {
  case initial
  case noToken
  case authenticated
  
  fileprivate var nextStates : [AuthState] {
    switch self {
    case .initial: return [.noToken, .authenticated]
    case .noToken : return [.authenticated]
    case .authenticated : return [.noToken]
    }
  }
  
  func support(target: APITargetType) -> Bool {
    if !target.isRequiredAuth {
      return true
    } else if target.isRequiredAuth && self == .authenticated {
      return true
    } else {
      return false
    }
  }
  
  func canTransitionTo(_ nextState: AuthState) -> Bool {
    return self.nextStates.contains(nextState)
  }
}
