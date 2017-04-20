//
//  StatusEntity.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/22/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation

struct StatusEntity : Error {
  var isSuccess : Bool
  var type : String
  var title : String
  var status : Int
  var errorCode : Int
  var detail : String
  var invalidParams : [String]
}
