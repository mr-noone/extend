//
//  Gradient.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 8/5/19.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import Foundation

public struct Gradient {
  let type: GradientType
  
  let startPoint: CGPoint
  let startRadius: Float
  
  let endPoint: CGPoint
  let endRadius: Float
  
  let colors: [UIColor]
  let locations: [Float]?
  
  var cgGradient: CGGradient? {
    return CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                      colors: colors.map { $0.cgColor } as CFArray,
                      locations: locations?.map { CGFloat($0) })
  }
  
  public init(type: GradientType,
              startPoint: CGPoint,
              startRadius: Float,
              endPoint: CGPoint,
              endRadius: Float,
              colors: [UIColor],
              locations: [Float]?) {
    self.type = type
    self.startPoint = startPoint
    self.startRadius = startRadius
    self.endPoint = endPoint
    self.endRadius = endRadius
    self.colors = colors
    self.locations = locations
  }
  
  public init(radial center: CGPoint,
              radius: Float = 1,
              locations: [Float]? = nil,
              colors: UIColor...) {
    self.init(type: .radial,
              startPoint: center,
              startRadius: 0,
              endPoint: center,
              endRadius: radius,
              colors: colors,
              locations: locations)
  }
  
  public init(linear direction: GradientDirection,
              locations: [Float]? = nil,
              colors: UIColor...) {
    self.init(type: .linear,
              startPoint: direction.startPoint,
              startRadius: 0,
              endPoint: direction.endPoint,
              endRadius: 0,
              colors: colors,
              locations: locations)
  }
}
