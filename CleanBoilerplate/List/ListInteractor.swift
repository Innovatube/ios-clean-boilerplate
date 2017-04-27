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
//      resourceHelper.cars().subscribe(onNext: { (entities) in
//        self.presenter.reload(data: entities.map{ $0.name ?? "" } )
//      }, onError: { (_) in
//        self.presenter.retrieveDataFailed()
//      })
  }
  
  func bidCar(id: Int, price: Int) {
//    resourceHelper.carBid(id: id, price: price).subscribe(onNext: { (_) in
//      self.presenter.biddingSuccess()
//    }) { (_) in
//      self.presenter.biddingFailed()
//    }
  }
  
}
