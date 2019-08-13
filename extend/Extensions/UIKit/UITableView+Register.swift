//
//  UITableView+Register.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 8/5/19.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import UIKit

public extension UITableView {
  func register<T: UITableViewCell & Reusable>(_ aClass: T.Type, for identifier: String = T.reuseIdentifier) {
    if let aClass = aClass as? NibRepresentable.Type {
      register(aClass.nib, forCellReuseIdentifier: identifier)
    } else {
      register(aClass, forCellReuseIdentifier: identifier)
    }
  }
  
  func register<T: UITableViewHeaderFooterView & Reusable>(_ aClass: T.Type, for identifier: String = T.reuseIdentifier) {
    if let aClass = aClass as? NibRepresentable.Type {
      register(aClass.nib, forHeaderFooterViewReuseIdentifier: identifier)
    } else {
      register(aClass, forHeaderFooterViewReuseIdentifier: identifier)
    }
  }
}
