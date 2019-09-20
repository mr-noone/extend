//
//  UIImage+Color.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 9/19/19.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import UIKit

extension UIImage {
  public convenience init?(color: UIColor, size: CGSize = .init(width: 1, height: 1), opaque: Bool = false, scale: CGFloat = UIScreen.main.scale) {
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale)
    defer { UIGraphicsEndImageContext() }
    
    color.setFill()
    UIBezierPath(rect: .init(origin: .zero, size: size)).fill()
    
    guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
    self.init(cgImage: image.cgImage!, scale: scale, orientation: image.imageOrientation)
  }
}
