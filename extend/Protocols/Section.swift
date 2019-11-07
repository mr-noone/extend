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
  
  func firstIndexPath(where predicate: (Element.Item) throws -> Bool) rethrows -> IndexPath? {
    for section in 0..<count {
      for item in 0..<countOfItems(in: section) {
        if try predicate(self[section].items[item]) {
          return IndexPath(item: item, section: section)
        }
      }
    }
    return nil
  }
  
  public func first(where predicate: (Element.Item) throws -> Bool) rethrows -> Element.Item? {
    guard let indexPath = try firstIndexPath(where: predicate) else { return nil }
    return self[indexPath]
  }
  
  mutating func append(_ newElement: Element.Item, in section: Int) {
    self[section].items.append(newElement)
  }
  
  mutating func append(_ newElement: Element.Item) {
    if count > 0 {
      self[count - 1].items.append(newElement)
    }
  }
  
  mutating func insert(_ newElement: Element.Item, at section: Int) {
    self[section].items.append(newElement)
  }
  
  mutating func insert(_ newElement: Element.Item, at indexPath: IndexPath) {
    self[indexPath.section].items.insert(newElement, at: indexPath.row)
  }
  
  mutating func remove(at indexPath: IndexPath) {
    self[indexPath.section].items.remove(at: indexPath.row)
  }
}
