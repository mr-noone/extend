//
//  String+Separated.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 8/14/19.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import Foundation

public extension StringProtocol where Self: RangeReplaceableCollection {
  mutating func insert(_ separator: Self, every n: Int) {
    for index in indices.reversed() where index != startIndex && distance(from: startIndex, to: index) % Int(n) == 0 {
      insert(contentsOf: separator, at: index)
    }
  }
  
  func inserting(_ separator: Self, every n: Int) -> Self {
    var string = self
    string.insert(separator, every: n)
    return string
  }
}
