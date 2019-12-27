//
//  Array+Unique.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 27.12.2019.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import Foundation

public extension Sequence where Iterator.Element: Hashable {
  func unique() -> [Iterator.Element] {
    var seen: [Iterator.Element: Bool] = [:]
    return self.filter { seen.updateValue(true, forKey: $0) == nil }
  }
}
