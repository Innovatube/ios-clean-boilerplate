//
//  ListView.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/21/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import UIKit

protocol ListViewInterface {
  func reloadWith(data: [String])
}

class ListView : UIViewController, ListViewInterface {
  var interactor : ListInteractorInterface!
  var router : MainRouter!
  
  @IBOutlet var tableView : UITableView!
  var data: [String] = []
  
  override func viewDidLoad() {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(requestReloadData(_:)), for: .valueChanged)
    tableView.refreshControl = refreshControl
    let settingButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(routeToAccountView))
    navigationItem.rightBarButtonItem = settingButton

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
//    cell.carEntity = data[indexPath.row]
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
