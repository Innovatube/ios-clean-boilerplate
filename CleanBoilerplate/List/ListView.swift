//
//  ListView.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/21/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import UIKit
import SideMenu

protocol ListViewInterface {
  func reloadWith(data: [String])
}

class ListView : UIViewController, ListViewInterface {
  var interactor : ListInteractorInterface!
  var router : MainRouter!
  var menuView: UIViewController?
  var burgerButton = HamburgerButton(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 30)))
  
  @IBOutlet var tableView : UITableView!
  var data: [String] = []
  
  override func viewDidLoad() {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(requestReloadData(_:)), for: .valueChanged)
    tableView.refreshControl = refreshControl
    
    tableView.dataSource = self
    tableView.delegate = self
    tableView.registerNib(forCellType: CarCell.self)
    
    let settingButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(routeToAccountView))
    navigationItem.rightBarButtonItem? = settingButton
    
    if let menuView = menuView { setup(menuView: menuView) }
  }
  
  func setup(menuView: UIViewController){
    let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: menuView)
    menuLeftNavigationController.leftSide = false
    SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
    SideMenuManager.menuFadeStatusBar = false
    SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
    SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    
    let burgerBarItem = UIBarButtonItem(customView: burgerButton)
    navigationItem.leftBarButtonItem = burgerBarItem
    burgerButton.addTarget(self, action: #selector(toogleMenu), for: .touchUpInside)
  }
  
  func toogleMenu(){
    if let menuView = SideMenuManager.menuLeftNavigationController {
      present(menuView, animated: true)
    }
  }
  
  func routeToAccountView(){
    router.displayAccountInfoView()
  }
  
  func routeToSettingView(){
    router.displaySettingView()
  }
  
  func requestReloadData(_ refreshControl: UIRefreshControl){
    interactor.requestReloadData(id: 1, offset: 10)
    refreshControl.endRefreshing()
  }
  
  func reloadWith(data: [String]) {
    self.data = data
    print("Reload with new data")
    tableView.reloadData()
  }
}

extension ListView :  UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(type: CarCell.self, for: indexPath)
    cell.indexPath = indexPath
    cell.carCellDelegate = self
    cell.carNameLabel.text = data[indexPath.row]
    return cell
  }
}

protocol CarCellDelegate {
  func bidButtonTouchUpInside(cell: CarCell)
}

extension ListView : CarCellDelegate {
  func bidButtonTouchUpInside(cell: CarCell) {
  }
}
