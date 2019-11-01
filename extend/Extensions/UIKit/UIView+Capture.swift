//
//  UIWindow+Capture.swift
//  extend
//
//  Created by Oleksandr Yakobshe on 01/11/2019.
//  Copyright © 2019 Skie. All rights reserved.
//

import UIKit

public extension UIView {
  func capture() -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, self.isOpaque, UIScreen.main.scale)
    self.layer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
}
