//
//  UITableView+Dequeue.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 8/5/19.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import UIKit

public extension UITableView {
  func dequeue<T: UITableViewCell & Reusable>(with identifier: String = T.reuseIdentifier, for indexPath: IndexPath) -> T {
    return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
  }
  
  func dequeue<T: UITableViewHeaderFooterView & Reusable>(with identifier: String = T.reuseIdentifier) -> T {
    return dequeueReusableHeaderFooterView(withIdentifier: identifier) as! T
  }
}
