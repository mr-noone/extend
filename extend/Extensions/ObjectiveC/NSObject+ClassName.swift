//
//  NSObject+ClassName.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 5/7/19.
//  Copyright © 2019 Aleksey Zgurskiy. All rights reserved.
//

import Foundation

public extension NSObject {
  static var className: String {
    return try! String(describing: self).substringMatches(regex: "[[:word:]]+").first!
  }
}
