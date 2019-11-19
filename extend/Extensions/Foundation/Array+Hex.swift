//
//  Array+Hex.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 19.11.2019.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import Foundation

public extension Array where Element == UInt8 {
  var hex: String {
    return reduce("") { (result, element) in
      result.appending(String(format: "%02x", element))
    }
  }
}
