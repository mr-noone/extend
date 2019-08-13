//
//  UIView+Round.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 5/17/19.
//  Copyright © 2019 Aleksey Zgurskiy. All rights reserved.
//

import UIKit

public extension UIView {
  func round(corners: UIRectCorner = .allCorners, radius: CGFloat) {
    if #available(iOS 11, *) {
      var maskedCorners = CACornerMask()
      
      if corners.contains(.topLeft) { maskedCorners.insert(.layerMinXMinYCorner) }
      if corners.contains(.topRight) { maskedCorners.insert(.layerMaxXMinYCorner) }
      if corners.contains(.bottomLeft) { maskedCorners.insert(.layerMinXMaxYCorner) }
      if corners.contains(.bottomRight) { maskedCorners.insert(.layerMaxXMaxYCorner) }
      
      layer.cornerRadius = radius
      layer.maskedCorners = maskedCorners
    } else {
      let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
      let mask = CAShapeLayer()
      mask.path = path.cgPath
      self.layer.mask = mask
    }
  }
}
