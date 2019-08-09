//
//  SeparatorView.swift
//  nothing
//
//  Created by Aleksey Zgurskiy on 5/7/19.
//  Copyright © 2019 Aleksey Zgurskiy. All rights reserved.
//

import UIKit

@IBDesignable
public class SeparatorView: NibView {
  public override var backgroundColor: UIColor? {
    get { return .clear }
    set {}
  }
  
  @IBOutlet private var separator: UIView! {
    didSet { separator.backgroundColor = color }
  }
  
  @IBOutlet private var leftConstraint: NSLayoutConstraint!
  @IBOutlet private var rightConstraint: NSLayoutConstraint!
  @IBOutlet private var topConstraint: NSLayoutConstraint!
  @IBOutlet private var bottomConstraint: NSLayoutConstraint!
  @IBOutlet private var heightConstraint: NSLayoutConstraint! {
    didSet { heightConstraint.constant = height }
  }
  
  @IBInspectable
  public var color: UIColor = .hex6(0xC8C7CC) {
    didSet { separator.backgroundColor = color }
  }
  
  @IBInspectable
  public var height: CGFloat = 1 / UIScreen.main.scale {
    didSet { heightConstraint.constant = height }
  }
  
  public var insets: UIEdgeInsets = .zero {
    didSet {
      topConstraint.constant = insets.top
      leftConstraint.constant = insets.left
      bottomConstraint.constant = insets.bottom
      rightConstraint.constant = insets.right
    }
  }
  
  @IBInspectable
  private var top: CGFloat {
    get { return insets.top }
    set { insets.top = newValue }
  }
  
  @IBInspectable
  private var left: CGFloat {
    get { return insets.left }
    set { insets.left = newValue }
  }
  
  @IBInspectable
  private var bottom: CGFloat {
    get { return insets.bottom }
    set { insets.bottom = newValue }
  }
  
  @IBInspectable
  private var right: CGFloat {
    get { return insets.right }
    set { insets.right = newValue }
  }
}
