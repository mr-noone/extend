//
//  UIImage+Resize.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 07.11.2019.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import UIKit

public extension UIImage {
  @available(iOS 10.0, *)
  func resize(new size: CGSize) -> UIImage? {
    defer { UIGraphicsEndImageContext() }
    UIGraphicsBeginImageContextWithOptions(size, true, 1)
    draw(in: CGRect(origin: .zero, size: size).integral)
    return UIGraphicsGetImageFromCurrentImageContext()
  }
  
  @available(iOS 10.0, *)
  func resize(maxSide size: CGFloat) -> UIImage? {
    let factor = size / max(self.size.width, self.size.height)
    return resize(new: CGSize(width: self.size.width * factor, height: self.size.height * factor))
  }
}
