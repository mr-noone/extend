//
//  Section.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 9/19/19.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import Foundation

public protocol Section {
  associatedtype Header
  associatedtype Footer
  associatedtype Item
  
  var header: Header? { get set }
  var footer: Footer? { get set }
  var items: [Item] { get set }
}

public extension Array where Element: Section {
  subscript(indexPath: IndexPath) -> Element.Item {
    get { return self[indexPath.section].items[indexPath.row] }
    set { self[indexPath.section].items[indexPath.row] = newValue }
  }
  
  func countOfItems(in section: Int) -> Int {
    return self[section].items.count
  }
}
