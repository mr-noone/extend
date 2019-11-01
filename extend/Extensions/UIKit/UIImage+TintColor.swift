//
//  UIImage+TintColor.swift
//  extend
//
//  Created by Oleksandr Yakobshe on 01/11/2019.
//  Copyright © 2019 Skie. All rights reserved.
//

import UIKit

public extension UIImage {
  func tintImage(with fillColor: UIColor, blendMode: CGBlendMode = .normal) -> UIImage {
    return modifiedImage { context, rect in
      context.setBlendMode(.normal)
      context.draw(cgImage!, in: rect)
      
      context.setBlendMode(blendMode)
      fillColor.setFill()
      context.fill(rect)
      
      context.draw(context.makeImage()!, in: rect)
    }
  }
  
  internal func modifiedImage(_ draw: (CGContext, CGRect) -> ()) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    let context: CGContext! = UIGraphicsGetCurrentContext()
    assert(context != nil)

    context.translateBy(x: 0, y: size.height)
    context.scaleBy(x: 1.0, y: -1.0)

    let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)

    draw(context, rect)

    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
}
