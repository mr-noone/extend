//
//  UIColor+Hex.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 5/7/19.
//  Copyright © 2019 Aleksey Zgurskiy. All rights reserved.
//

import UIKit

public extension UIColor {
  class func hex1(_ hex: UInt8, alpha: Float = 1) -> UIColor {
    return UIColor(hex1: hex, alpha: alpha)
  }
  
  class func hex2(_ hex: UInt8, alpha: Float = 1) -> UIColor {
    return UIColor(hex2: hex, alpha: alpha)
  }
  
  class func hex3(_ hex: UInt16, alpha: Float = 1) -> UIColor {
    return UIColor(hex3: hex, alpha: alpha)
  }
  
  class func hex6(_ hex: UInt32, alpha: Float = 1) -> UIColor {
    return UIColor(hex6: hex, alpha: alpha)
  }
  
  convenience init(hex1 hex: UInt8, alpha: Float = 1) {
    let w = CGFloat(hex) / 0xf
    self.init(white: w, alpha: CGFloat(alpha))
  }
  
  convenience init(hex2 hex: UInt8, alpha: Float = 1) {
    let w = CGFloat(hex) / 0xff
    self.init(white: w, alpha: CGFloat(alpha))
  }
  
  convenience init(hex3 hex: UInt16, alpha: Float = 1) {
    let r = CGFloat((hex & 0xf00) >> 0x8) / 0xf
    let g = CGFloat((hex & 0x0f0) >> 0x4) / 0xf
    let b = CGFloat((hex & 0x00f) >> 0x0) / 0xf
    self.init(red: r, green: g, blue: b, alpha: CGFloat(alpha))
  }
  
  convenience init(hex6 hex: UInt32, alpha: Float = 1) {
    let r = CGFloat((hex & 0xff0000) >> 0x10) / 0xff
    let g = CGFloat((hex & 0x00ff00) >> 0x08) / 0xff
    let b = CGFloat((hex & 0x0000ff) >> 0x00) / 0xff
    self.init(red: r, green: g, blue: b, alpha: CGFloat(alpha))
  }
}
