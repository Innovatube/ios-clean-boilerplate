//
//  ReusableView.swift
//  CarBid
//
//  Created by Khoi Truong Minh on 9/1/16.
//  Copyright © 2016 Khoi Truong Minh. All rights reserved.
//

import UIKit

protocol ReusableView: class {

    static var reuseIdentifier: String { get }

}

extension ReusableView where Self: UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

}
