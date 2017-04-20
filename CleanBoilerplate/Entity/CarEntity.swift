//
//  CarEntity.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/22/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation
import RealmSwift

class CarEntity : Object {
  var id : Int?
  var name : String?
  var yom : Date?
  var mileage : Int?
  var desc : String?
  var closeAt : Int?
  var numberOfBids : Int?
  var isBidded : Bool?
  var biddingPrice : Int?
  
  override class func primaryKey() -> String? {
    return "id"
  }
}
