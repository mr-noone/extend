//
//  Kindable.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 10/2/19.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import Foundation

public protocol Kindable: Reusable {
  static var kind: String { get }
}
