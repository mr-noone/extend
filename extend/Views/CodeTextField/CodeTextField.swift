//
//  CodeTextField.swift
//  extend
//
//  Created by Oleksandr Yakobshe on 13/08/2019.
//  Copyright © 2019 mr.noone. All rights reserved.
//

import UIKit

@objc public protocol CodeTextFieldDelegate {
  @objc optional func textFieldShouldBeginEditing(_ textField: CodeTextField) -> Bool
  @objc optional func textFieldDidBeginEditing(_ textField: CodeTextField)
  
  @objc optional func textFieldShouldEndEditing(_ textField: CodeTextField) -> Bool
  @objc optional func textFieldDidEndEditing(_ textField: CodeTextField)
  
  @objc optional func textField(_ textField: CodeTextField, shouldEnter string: String) -> Bool
  @objc optional func textFieldShouldReturn(_ textField: CodeTextField) -> Bool
}

@IBDesignable
open class CodeTextField: NibControl {
  // MARK: - Outlets
  
  @IBOutlet weak var delegate: CodeTextFieldDelegate?
  
  @IBOutlet private var stackView: UIStackView! {
    didSet {
      stackView.alignment = .fill
      stackView.distribution = .fillEqually
      stackView.spacing = 8
      stackView.addGestureRecognizer(tapGestureRecognition)
    }
  }
  
  // MARK: - Properties
  
  open override var tintColor: UIColor! {
    didSet { characterViews.forEach { $0.tintColor = tintColor } }
  }
  
  public var font: UIFont! = .systemFont(ofSize: 17) {
    didSet { characterViews.forEach { $0.font = font } }
  }
  
  @IBInspectable
  public var text: String! {
    get { return characterViews.compactMap { $0.text }.joined() }
    set {
      switch newValue {
      case let text?:
        characterViews.enumerated().forEach {
          let character = text.count > $0.offset ? String(Array(text)[$0.offset]) : nil
          $0.element.text = character
        }
      default:
        characterViews.forEach { $0.text = nil }
      }
      
      sendActions(for: [.valueChanged, .editingChanged])
    }
  }
  
  @IBInspectable
  public var characterSize: CGSize = .init(width: 40, height: 50) {
    didSet {
      characterViews.forEach {
        $0.width = characterSize.width
        $0.height = characterSize.height
      }
    }
  }
  
  @IBInspectable
  public var spacing: CGFloat {
    get { return stackView.spacing }
    set { stackView.spacing = newValue }
  }
  
  @IBInspectable
  open var characterLimits: UInt8 = 4 {
    didSet { updateCharacterViews() }
  }
  
  open override var canBecomeFirstResponder: Bool {
    return true
  }
  
  // MARK: - Lifecycle
  
  open override func viewDidInit() {
    super.viewDidInit()
    updateCharacterViews()
  }
  
  // MARK: - Responder handlers
  
  open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    switch action {
    case #selector(UIResponderStandardEditActions.paste(_:)):
      return true
    default:
      return false
    }
  }
  
  open override func becomeFirstResponder() -> Bool {
    if delegate?.textFieldShouldBeginEditing?(self) ?? true {
      delegate?.textFieldDidBeginEditing?(self)
      sendActions(for: .editingDidBegin)
      return super.becomeFirstResponder()
    } else {
      return false
    }
  }
  
  open override func resignFirstResponder() -> Bool {
    if delegate?.textFieldShouldEndEditing?(self) ?? true {
      delegate?.textFieldDidEndEditing?(self)
      sendActions(for: .editingDidEnd)
      return super.resignFirstResponder()
    } else {
      return false
    }
  }
  
  // MARK: - Event handlers
  
  open override func paste(_ sender: Any?) {
    text += (UIPasteboard.general.string ?? "").filter {
      delegate?.textField?(self, shouldEnter: String($0)) ?? true
    }
  }
}

// MARK: - Private

private extension CodeTextField {
  // MARK: - Properties
  
  private var tapGestureRecognition: UITapGestureRecognizer {
    get {
      let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
      return tap
    }
  }
  
  private var menu: UIMenuController {
    get {
      let menu = UIMenuController.shared
      menu.setTargetRect(CGRect.zero, in: self)
      return menu
    }
  }
  
  var characterViews: [CharacterView] {
    return stackView.arrangedSubviews as! [CharacterView]
  }
  
  // MARK: - Private
  
  @objc func didTap(_ sender: UITapGestureRecognizer) {
    switch (sender.state, isFirstResponder) {
    case (.ended, false):
      if bounds.contains(sender.location(in: self)) {
        _ = becomeFirstResponder()
      }
    case (.ended, true):
      menu.setMenuVisible(true, animated: true)
    default:
      break
    }
  }
  
  func updateCharacterViews() {
    stackView.arrangedSubviews.forEach {
      stackView.removeArrangedSubview($0)
    }
    
    for _ in 0..<characterLimits {
      let characterView = CharacterView()
      characterView.font = font
      characterView.tintColor = tintColor
      characterView.width = characterSize.width
      characterView.height = characterSize.height
      stackView.addArrangedSubview(characterView)
    }
  }
}

// MARK: - UIKeyInput

extension CodeTextField: UIKeyInput {
  public var hasText: Bool {
    return !text.isEmpty
  }
  
  public func insertText(_ text: String) {
    if text.trimmingCharacters(in: .newlines).isEmpty && delegate?.textFieldShouldReturn?(self) ?? true {
      _ = resignFirstResponder()
    } else if delegate?.textField?(self, shouldEnter: text) ?? true {
      self.text += text
    }
  }
  
  public func deleteBackward() {
    guard hasText else { return }
    text?.removeLast()
  }
}
