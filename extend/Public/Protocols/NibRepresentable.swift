//
//  NibRepresentable.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 5/7/19.
//  Copyright © 2019 Aleksey Zgurskiy. All rights reserved.
//

import UIKit

public protocol NibRepresentable where Self: UIView {
  static var bundle: Bundle { get }
  static var nibName: String { get }
  static var nib: UINib { get }
}

public extension NibRepresentable {
  static var bundle: Bundle {
    return Bundle(for: self)
  }
  
  static var nibName: String {
    return className
  }
  
  static var nib: UINib {
    return UINib(nibName: nibName, bundle: bundle)
  }
}
