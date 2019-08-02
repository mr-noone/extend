//
//  NibLoadable.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 5/7/19.
//  Copyright © 2019 Aleksey Zgurskiy. All rights reserved.
//

import UIKit

public protocol NibLoadable: NibRepresentable {
  func loadNib(_ nib: UINib) -> UIView?
}

public extension NibLoadable {
  @discardableResult
  func loadNib(_ nib: UINib) -> UIView? {
    guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
    else { return nil }
    
    addSubview(view)
    
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .clear
    view.frame = bounds
    
    NSLayoutConstraint.activate([
      view.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
      view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
    ])
    
    return view
  }
}
