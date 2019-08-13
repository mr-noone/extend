//
//  IBDrawable.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 8/9/19.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import Foundation

public protocol IBDrawable where Self: UIView {
  func drawForInterfaceBuilder()
}

public extension IBDrawable {
  func drawForInterfaceBuilder() {
    UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
    
    UIColor.white.setStroke()
    UIColor(hex6: 0x0C83B5, alpha: 0.4).setFill()
    
    UIBezierPath(rect: bounds).fill()
    UIBezierPath(rect: bounds.insetBy(dx: 2, dy: 2)).stroke()
    
    let text = NSAttributedString(string: type(of: self).className, attributes: [
      NSAttributedString.Key.foregroundColor : UIColor.white,
      NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13, weight: .heavy)
      ])
    
    let textBounds = text.boundingRect(with: bounds.size, options: .truncatesLastVisibleLine, context: nil)
    let textPosition = CGPoint(x: (bounds.width - textBounds.width) / 2, y: (bounds.height - textBounds.height) / 2)
    let textRect = CGRect(origin:textPosition , size: textBounds.size)
    
    text.draw(in: textRect)
    
    layer.contents = UIGraphicsGetImageFromCurrentImageContext()?.cgImage
    
    UIGraphicsEndImageContext()
  }
}
