//
//  NSAttributedString+Attachment.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 9/25/19.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import Foundation

public extension NSAttributedString {
  convenience init(attachment: NSTextAttachment, attributes attrs: [NSAttributedString.Key : Any]?) {
    let str = NSMutableAttributedString(attachment: attachment)
    str.addAttributes(attrs ?? [:], range: .init(location: 0, length: str.length))
    self.init(attributedString: str)
  }
}
