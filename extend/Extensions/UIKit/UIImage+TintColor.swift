//
//  UIImage+TintColor.swift
//  extend
//
//  Created by Oleksandr Yakobshe on 01/11/2019.
//  Copyright © 2019 Skie. All rights reserved.
//

import UIKit

public extension UIImage {
  func image(with tintColor: UIColor, blendMode: CGBlendMode = .normal) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    let context: CGContext! = UIGraphicsGetCurrentContext()

    context.translateBy(x: 0, y: size.height)
    context.scaleBy(x: 1.0, y: -1.0)

    let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)

    context.setBlendMode(.normal)
    context.draw(cgImage!, in: rect)
    
    context.setBlendMode(blendMode)
    tintColor.setFill()
    context.fill(rect)
    
    context.draw(context.makeImage()!, in: rect)

    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
}
