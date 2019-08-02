//
//  TextField.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 5/7/19.
//  Copyright © 2019 Aleksey Zgurskiy. All rights reserved.
//

import UIKit

open class TextField: UITextField {
  open var textInsets: UIEdgeInsets = .zero
  open var leftViewInsets: UIEdgeInsets = .zero
  open var rightViewInsets: UIEdgeInsets = .zero
  
  open var placeholderAttributes: [NSAttributedString.Key : Any]? {
    didSet { needsUpdatePlaceholder() }
  }
  
  open override var placeholder: String? {
    didSet { needsUpdatePlaceholder() }
  }
  
  open override func textRect(forBounds bounds: CGRect) -> CGRect {
    return super.textRect(forBounds: bounds).inset(by: textInsets)
  }
  
  open override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return super.editingRect(forBounds: bounds).inset(by: textInsets)
  }
  
  open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
    return super.leftViewRect(forBounds: bounds).inset(by: leftViewInsets)
  }
  
  open override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
    return super.rightViewRect(forBounds: bounds).inset(by: rightViewInsets)
  }
}

private extension TextField {
  func needsUpdatePlaceholder() {
    if let placeholder = placeholder, let attributes = placeholderAttributes {
      attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
    }
  }
}
