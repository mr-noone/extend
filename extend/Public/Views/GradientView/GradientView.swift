//
//  GradientView.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 5/7/19.
//  Copyright © 2019 Aleksey Zgurskiy. All rights reserved.
//

import UIKit

public enum GradientDirection: Int {
  case vertical
  case horizontal
  case diagonalLeft
  case diagonalRight
  
  var startPoint: CGPoint {
    switch self {
    case .vertical: return CGPoint(x: 0.5, y: 0.0)
    case .horizontal: return CGPoint(x: 0.0, y: 0.5)
    case .diagonalLeft: return CGPoint(x: 0.0, y: 0.0)
    case .diagonalRight: return CGPoint(x: 1.0, y: 0.0)
    }
  }
  
  var endPoint: CGPoint {
    switch self {
    case .vertical: return CGPoint(x: 0.5, y: 1.0)
    case .horizontal: return CGPoint(x: 1.0, y: 0.5)
    case .diagonalLeft: return CGPoint(x: 1.0, y: 1.0)
    case .diagonalRight: return CGPoint(x: 0.0, y: 1.0)
    }
  }
}

public struct Gradient {
  public let startPoint: CGPoint
  public let endPoint: CGPoint
  public let colors: [UIColor]
  public let locations: [Float]?
  
  public var cgGradient: CGGradient? {
    return CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                      colors: self.colors.map { $0.cgColor } as CFArray,
                      locations: self.locations?.map { CGFloat($0) })
  }
  
  private init(startPoint: CGPoint = .zero,
               endPoint: CGPoint = .init(x: 0, y: 1),
               colors: [UIColor],
               locations: [Float]? = nil) {
    self.startPoint = startPoint
    self.endPoint = endPoint
    self.colors = colors
    self.locations = locations
  }
  
  public init(startPoint: CGPoint = .zero,
              endPoint: CGPoint = .init(x: 0, y: 1),
              colors: UIColor...,
              locations: [Float]?) {
    self.init(startPoint: startPoint,
              endPoint: endPoint,
              colors: colors,
              locations: locations)
  }
  
  public init(linear direction: GradientDirection = .vertical, colors: UIColor...) {
    self.init(startPoint: direction.startPoint,
              endPoint: direction.endPoint,
              colors: colors,
              locations: nil)
  }
}

@IBDesignable
open class GradientView: UIView {
  @IBInspectable private var firstColor: UIColor = .clear { didSet { needsUpdateGradient() }}
  @IBInspectable private var lastColor: UIColor = .clear { didSet { needsUpdateGradient() }}
  @IBInspectable private var direction: Int = 0 { didSet { needsUpdateGradient() }}
  
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
  
  private func needsUpdateGradient() {
    gradient = Gradient.init(linear: GradientDirection(rawValue: direction) ?? .vertical,
                             colors: firstColor, lastColor)
  }
  
  open override func draw(_ rect: CGRect) {
    guard
      let ctx = UIGraphicsGetCurrentContext(),
      let gradient = gradient,
      let cgGradient = gradient.cgGradient
    else { return }
    
    let startPoint = CGPoint(x: rect.width * gradient.startPoint.x,
                             y: rect.height * gradient.startPoint.y)
    let endPoint = CGPoint(x: rect.width * gradient.endPoint.x,
                           y: rect.height * gradient.endPoint.y)
    ctx.drawLinearGradient(cgGradient,
                           start: startPoint,
                           end: endPoint,
                           options: [])
  }
}
