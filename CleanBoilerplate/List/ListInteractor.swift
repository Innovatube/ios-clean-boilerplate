//
//  ListInteractor.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/21/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import Foundation

protocol ListInteractorInterface {
  func requestReloadData(id: Int, offset: Int)
  func bidCar(id: Int, price: Int)
  
}

class ListInteractor : ListInteractorInterface {
  var presenter : ListPresenterInterface!
  
  func requestReloadData(id: Int, offset: Int) {
    presenter.reload(data: ["Test"])
  }
  
  func bidCar(id: Int, price: Int) {
    // Send bidding request
    // If success
//    presenter.bidding(isSuccess: true)
    presenter.reload(data: ["Test", "Another"])
  }
  
}
