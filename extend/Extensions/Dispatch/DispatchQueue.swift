//
//  DispatchQueue.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 21.12.2019.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import Dispatch

extension DispatchQueue {
  private static var onceTokens = [String]()
  
  public class func once(file: NSString = #file,
                  function: NSString = #function,
                  line: Int = #line,
                  block: () -> ()) {
    once(token: "\(file.lastPathComponent):\(function):\(line)", block: block)
  }
  
  public class func once(token: String, block: () -> ()) {
    objc_sync_enter(self)
    defer { objc_sync_exit(self) }
    
    if onceTokens.contains(token) {
      return
    }
    
    onceTokens.append(token)
    block()
  }
}
