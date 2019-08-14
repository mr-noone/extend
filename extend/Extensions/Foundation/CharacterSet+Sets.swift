//
//  CharacterSet+Sets.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 8/14/19.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import Foundation

public extension CharacterSet {
  static var phoneNumberSet: CharacterSet {
    var set = CharacterSet.decimalDigits
    set.insert(charactersIn: "+")
    return set
  }
}
