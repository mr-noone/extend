//
//  UICollectionView+Register.swift
//  extend
//
//  Created by Roman Derevianko on 8/20/19.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import UIKit

public extension UICollectionView {
  func register<T: UICollectionViewCell & Reusable>(_ aClass: T.Type, for identifire: String = T.reuseIdentifier) {
    if let aClass = aClass as? NibRepresentable.Type {
      register(aClass.nib, forCellWithReuseIdentifier: identifire)
    } else {
      register(aClass, forCellWithReuseIdentifier: identifire)
    }
  }
}
