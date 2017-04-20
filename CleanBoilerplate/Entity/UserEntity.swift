//
//  UserEntity.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/21/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation
import RealmSwift

class UserEntity : Object {
  var id : Int?
  var name : String?
  var email : String?
  var isAdmin : Bool?
  
  override class func primaryKey() -> String? {
    return "id"
  }
}
