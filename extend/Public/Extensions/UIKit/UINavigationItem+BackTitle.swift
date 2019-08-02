//
//  UINavigationItem+BackTitle.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 5/17/19.
//  Copyright © 2019 Aleksey Zgurskiy. All rights reserved.
//

import Foundation

public extension UINavigationItem {
  func setBackButtonTitle(_ title: String) {
    perform(NSSelectorFromString("setBackButtonTitle:"), with: title)
  }
}
