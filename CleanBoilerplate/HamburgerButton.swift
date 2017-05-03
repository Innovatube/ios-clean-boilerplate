//
//  HamburgerButton.swift
//  CleanBoilerplate
//
//  Created by Do Dinh Thy  Son  on 4/28/17.
//  Copyright © 2017 Do Dinh Thy  Son . All rights reserved.
//

import CoreGraphics
import QuartzCore
import UIKit

public class HamburgerButton: UIButton {
  
  public var color: UIColor = UIColor.blue {
    didSet {
      for shapeLayer in shapeLayers {
        shapeLayer.strokeColor = color.cgColor
      }
    }
  }
  
  private let top: CAShapeLayer = CAShapeLayer()
  private let middle: CAShapeLayer = CAShapeLayer()
  private let bottom: CAShapeLayer = CAShapeLayer()
  private let width: CGFloat = 25
  private let height: CGFloat = 25
  private let topYPosition: CGFloat = 2
  private let middleYPosition: CGFloat = 9
  private let bottomYPosition: CGFloat = 16
  
  override public var intrinsicContentSize: CGSize {
    return CGSize(width: width, height: height)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: width, y: 0))
    
    for shapeLayer in shapeLayers {
      shapeLayer.path = path.cgPath
      shapeLayer.lineWidth = 2
      shapeLayer.strokeColor = color.cgColor
      
      let strokingPath = CGPath(__byStroking: shapeLayer.path!, transform: nil, lineWidth: shapeLayer.lineWidth, lineCap: CGLineCap.butt, lineJoin: CGLineJoin.miter, miterLimit: shapeLayer.miterLimit)
      // Otherwise bounds will be equal to CGRectZero.
      shapeLayer.bounds = strokingPath!.boundingBoxOfPath
      layer.addSublayer(shapeLayer)
    }
    
    let widthMiddle = width / 2
    top.position = CGPoint(x: widthMiddle, y: topYPosition)
    middle.position = CGPoint(x: widthMiddle, y: middleYPosition)
    bottom.position = CGPoint(x: widthMiddle, y: bottomYPosition)
  }
  
  
  private var shapeLayers: [CAShapeLayer] {
    return [top, middle, bottom]
  }
}

