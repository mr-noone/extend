//
//  UICollectionView+Dequeue.swift
//  extend
//
//  Created by Roman Derevianko on 8/20/19.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import UIKit

public extension UICollectionView {
  func dequeue<T: UICollectionViewCell & Reusable>(with identifire: String = T.reuseIdentifier, for indexPath: IndexPath) -> T {
    return dequeueReusableCell(withReuseIdentifier: identifire, for: indexPath) as! T
  }
}
