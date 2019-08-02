//
//  KeyboardController.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 5/17/19.
//  Copyright © 2019 Aleksey Zgurskiy. All rights reserved.
//

import UIKit

@objc public protocol KeyboardControllerDelegate {
  @objc optional func keyboardWillShow(_ userInfo: [AnyHashable : Any])
  @objc optional func keyboardWillHide(_ userInfo: [AnyHashable : Any])
}

public class KeyboardController: NSObject {
  // MARK: - Outlets
  
  @IBOutlet public weak var scrollView: UIScrollView? {
    didSet { defaultInset = scrollView?.contentInset ?? .zero }
  }
  
  @IBOutlet public weak var delegate: KeyboardControllerDelegate?
  
  // MARK: - Properties
  
  private var defaultInset: UIEdgeInsets = .zero
  
  // MARK: - Lifecycle
  
  public override init() {
    super.init()
    
    let sel = #selector(keyboardNotification(_:))
    let center = NotificationCenter.default
    center.addObserver(self, selector: sel, name: UIView.keyboardWillShowNotification, object: nil)
    center.addObserver(self, selector: sel, name: UIView.keyboardWillHideNotification, object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  // MARK: - Actions
  
  @objc private func keyboardNotification(_ notification: Notification) {
    guard let userInfo = notification.userInfo else { return }
    
    var inset = scrollView?.contentInset ?? .zero
    
    switch notification.name {
    case UIView.keyboardWillShowNotification:
      delegate?.keyboardWillShow?(userInfo)
      let frame = (userInfo[UIView.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
      let offset = (scrollView?.window?.frame.height ?? 0) - (scrollView?.frame.maxY ?? 0)
      inset.bottom = frame.height - offset
    case UIView.keyboardWillHideNotification:
      delegate?.keyboardWillHide?(userInfo)
      inset = defaultInset
    default:
      return
    }
    
    scrollView?.contentInset = inset
  }
}
