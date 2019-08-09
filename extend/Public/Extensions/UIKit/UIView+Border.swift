//
//  UIView+Border.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 8/9/19.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import UIKit

public extension UIView {
  func border(color: UIColor, width: Float, corners: UIRectCorner = .allCorners, radius: CGFloat) {
    border(color: color, width: CGFloat(width), corners: corners, radius: radius)
  }
  
  func border(color: UIColor, width: CGFloat, corners: UIRectCorner = .allCorners, radius: CGFloat) {
    round(corners: corners, radius: radius)
    layer.borderColor = color.cgColor
    layer.borderWidth = width
  }
}
