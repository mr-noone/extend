//
//  CGRect+Offsets.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 9/23/19.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import CoreGraphics

public typealias UIEdgeOffsets = UIEdgeInsets

public extension CGRect {
  func offset(by offsets: UIEdgeOffsets) -> CGRect {
    var rect = self
    rect.origin.x -= offsets.left
    rect.origin.y -= offsets.top
    rect.size.width += offsets.left + offsets.right
    rect.size.height += offsets.top + offsets.bottom
    return rect
  }
}
