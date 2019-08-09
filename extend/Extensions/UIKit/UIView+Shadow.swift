//
//  UIView+Shadow.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 8/5/19.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import UIKit

public struct Shadow {
  let color: UIColor?
  let radius: Float
  let opacity: Float
  let offset: CGPoint
  let path: CGPath?
  
  public init(color: UIColor? = nil, radius: Float, opacity: Float, offset: CGPoint, path: CGPath? = nil) {
    self.color = color
    self.radius = radius
    self.opacity = opacity
    self.offset = offset
    self.path = path
  }
}

public extension UIView {
  private var shadowColor: UIColor? {
    get { return layer.shadowColor != nil ? UIColor(cgColor: layer.shadowColor!) : nil }
    set { layer.shadowColor = newValue?.cgColor }
  }
  
  private var shadowRadius: Float? {
    get { return Float(layer.shadowRadius) }
    set { layer.shadowRadius = CGFloat(newValue ?? 0) }
  }
  
  private var shadowOpacity: Float? {
    get { return layer.shadowOpacity }
    set { layer.shadowOpacity = newValue ?? 0 }
  }
  
  private var shadowOffset: CGPoint? {
    get { return CGPoint(x: layer.shadowOffset.width, y: layer.shadowOffset.height) }
    set { layer.shadowOffset = CGSize(width: newValue?.x ?? 0, height: newValue?.y ?? 0) }
  }
  
  private var shadowPath: CGPath? {
    get { return layer.shadowPath }
    set { layer.shadowPath = newValue }
  }
  
  var shadow: Shadow? {
    get {
      guard
        let shadowRadius = shadowRadius,
        let shadowOpacity = shadowOpacity,
        let shadowOffset = shadowOffset
      else {
        return nil
      }
      
      return Shadow(color: shadowColor,
                    radius: shadowRadius,
                    opacity: shadowOpacity,
                    offset: shadowOffset,
                    path: shadowPath)
    }
    set {
      shadowColor = newValue?.color
      shadowRadius = newValue?.radius
      shadowOpacity = newValue?.opacity
      shadowOffset = newValue?.offset
      shadowPath = newValue?.path
    }
  }
}
