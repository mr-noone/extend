//
//  TextView.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 9/23/19.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import UIKit

@IBDesignable
open class TextView: UITextView {
  // MARK: - Properties
  
  open var placeholder: String? {
    didSet { setNeedsDisplay() }
  }
  
  open var placeholderColor: UIColor = .lightGray {
    didSet { setNeedsDisplay() }
  }
  
  open var placeholderAttributes: [NSAttributedString.Key : Any]? {
    didSet { setNeedsDisplay() }
  }
  
  open var attributedPlaceholder: NSAttributedString {
    return NSAttributedString(string: placeholder ?? "", attributes: placeholderAttributes ?? [
      NSAttributedString.Key.foregroundColor : placeholderColor,
      NSAttributedString.Key.font : font ?? UIFont.systemFont(ofSize: UIFont.systemFontSize),
      NSAttributedString.Key.paragraphStyle : NSMutableParagraphStyle().then {
        $0.alignment = textAlignment
      }
    ])
  }
  
  open override var text: String! {
    didSet { setNeedsDisplay() }
  }
  
  // MARK: - Inits
  
  public override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    commonInit()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(textDidChange(_:)),
                                           name: UITextView.textDidChangeNotification,
                                           object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: - Drawing
  
  open override func draw(_ rect: CGRect) {
    super.draw(rect)
    
    if text.isEmpty {
      let textRect = rect.inset(by: textContainerInset)
        .insetBy(dx: textContainer.lineFragmentPadding, dy: 0)
      attributedPlaceholder.draw(in: textRect)
    }
  }
  
  // MARK: - Notification handlers
  
  @objc open func textDidChange(_ notification: Notification) {
    setNeedsDisplay()
  }
}
