//
//  GradientView.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 5/7/19.
//  Copyright © 2019 Aleksey Zgurskiy. All rights reserved.
//

import UIKit

@IBDesignable
open class GradientView: UIView, IBDrawable {
  open var gradient: Gradient? = nil {
    didSet { setNeedsDisplay() }
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  public convenience init(gradient: Gradient) {
    self.init(frame: .zero)
    self.gradient = gradient
  }
  
  open override func prepareForInterfaceBuilder() {
    drawForInterfaceBuilder()
  }
  
  #if !TARGET_INTERFACE_BUILDER
  open override func draw(_ rect: CGRect) {
    guard
      let ctx = UIGraphicsGetCurrentContext(),
      let gradient = gradient,
      let cgGradient = gradient.cgGradient
    else { return }
    
    let options: CGGradientDrawingOptions = [
      .drawsBeforeStartLocation,
      .drawsAfterEndLocation
    ]
    let startPoint = CGPoint(x: rect.width * gradient.startPoint.x,
                             y: rect.height * gradient.startPoint.y)
    let endPoint = CGPoint(x: rect.width * gradient.endPoint.x,
                           y: rect.height * gradient.endPoint.y)
    
    switch gradient.type {
    case .linear:
      ctx.drawLinearGradient(cgGradient,
                             start: startPoint,
                             end: endPoint,
                             options: options)
    case .radial:
      let startRadius = max(rect.width, rect.height) * CGFloat(gradient.startRadius)
      let endRadius = max(rect.width, rect.height) * CGFloat(gradient.endRadius)
      
      ctx.drawRadialGradient(cgGradient,
                             startCenter: startPoint,
                             startRadius: startRadius,
                             endCenter: endPoint,
                             endRadius: endRadius,
                             options: options)
    }
  }
  #endif
}
