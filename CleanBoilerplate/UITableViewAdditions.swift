//
//  UITableViewAdditions.swift
//  CarBid
//
//  Created by Khoi Truong Minh on 7/7/16.
//  Copyright © 2016 Khoi Truong Minh. All rights reserved.
//

import UIKit

extension UITableView {

    func updateTableHeaderView(size: CGSize) {
        let headerView = tableHeaderView
        headerView?.setNeedsLayout()
        headerView?.layoutIfNeeded()
        headerView?.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        tableHeaderView = headerView
    }

    func updateTableHeaderView(height: CGFloat) {
        updateTableHeaderView(size: CGSize(width: bounds.size.width, height: height))
    }

    func updateTableFooterView(size: CGSize) {
        let footerView = tableFooterView
        footerView?.setNeedsLayout()
        footerView?.layoutIfNeeded()
        footerView?.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        tableFooterView = footerView
    }

    func updateTableFooterView(height: CGFloat) {
        updateTableFooterView(size: CGSize(width: bounds.size.width, height: height))
    }

}

extension UITableView {

    func registerNib<T: UITableViewCell>(forCellType type: T.Type) where T: ReusableView, T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func registerNib<T: UITableViewCell>(forCellTypes types: [T.Type]) where T: ReusableView, T: NibLoadableView {
        for type in types {
            registerNib(forCellType: type)
        }
    }

}

extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(type: T.Type, for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func dequeueReusableCell<T: UITableViewCell>(type: T.Type) -> T where T: ReusableView {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

}
