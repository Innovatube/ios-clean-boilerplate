//
//  MainRouter.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/16/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import UIKit

class MainRouter {
  var navigationController = UINavigationController()
  
  func displayLoginView() {
    guard let view : LoginView = UIStoryboard.main.instantiateVC() else {
      print("Error getting LoginView")
      return
    }
    
    let presenter = LoginPresenter()
    let interactor = LoginInteractor()
  
    view.interactor = interactor
    interactor.presenter = presenter
    interactor.resourceHelper = AccountResourceHelper()
    presenter.view = view
    view.router = self
    
    navigationController.pushViewController(view, animated: true)
  }
  
  func displayListView() {
    guard let view : ListView = UIStoryboard.main.instantiateVC() else {
      print("Error getting ListView")
      return
    }
    let presenter = ListPresenter()
    let interactor = ListInteractor()
    
    view.interactor = interactor
    interactor.presenter = presenter
    interactor.resourceHelper = CarResourceHelper()
    presenter.view = view
    view.router = self
    
    navigationController.pushViewController(view, animated: true)
  }
  
  func displayAccountInfoView() {
    guard let view : AccountInfoView = UIStoryboard.main.instantiateVC() else {
      print("Error getting AccountInfo view")
      return
    }
    let presenter = AccountInfoPresenter()
    let interactor = AccountInfoInteractor()
    
    view.interactor = interactor
    interactor.presenter = presenter
    interactor.resourceHelper = AccountResourceHelper()
    presenter.view = view
    view.router = self
    
    navigationController.pushViewController(view, animated: true)
  }
  
  func displaySettingView(){
    
  }
}
