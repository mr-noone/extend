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
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
  
  func round(corners: UIRectCorner = .allCorners) {
    round(corners: corners, radius: min(frame.width, frame.height) / 2)
  }
}
