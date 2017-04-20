//
//  NibNameExtension.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 3/22/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import UIKit

protocol NibLoadableView: class {
  
  static var nibName: String { get }
  
}

extension NibLoadableView where Self: UIView {
  
  static var nibName: String {
    return String(describing: self)
  }
  
}

extension NibLoadableView where Self: UIView {
  
  static func instantiateView() -> Self {
    guard let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as? Self else {
      fatalError("Can not load nib with name '\(nibName)'")
    }
    return view
  }
  
}

extension UIStoryboard {
  static let main = UIStoryboard(name: "Main", bundle: nil)
  
  func instantiateVC<T: UIViewController>() -> T? {
    // get a class name and demangle for classes in Swift
    if let name = NSStringFromClass(T.self).components(separatedBy: ".").last {
      return instantiateViewController(withIdentifier: name) as? T
    }
    return nil
  }
  
}

