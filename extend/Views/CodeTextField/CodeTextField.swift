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
open class CodeTextField: NibControl, UITextInputTraits {
  // MARK: - Outlets
  
  @IBOutlet weak open var delegate: CodeTextFieldDelegate?
  
  @IBOutlet private var stackView: UIStackView! {
    didSet {
      stackView.alignment = .fill
      stackView.distribution = .fillEqually
      stackView.spacing = 8
      stackView.addGestureRecognizer(tapGestureRecognition)
    }
  }
  
  // MARK: - Properties
  
  open var keyboardType: UIKeyboardType = .default
  open var keyboardAppearance: UIKeyboardAppearance = .default
  open var returnKeyType: UIReturnKeyType = .default
  open var textContentType: UITextContentType! = .none
  
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
      menu.setTargetRect(bounds, in: self)
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
      menu.setMenuVisible(!menu.isMenuVisible, animated: true)
      
    default:
      break
    }
  }
  
  func updateCharacterViews() {
    stackView.arrangedSubviews.forEach {
      $0.removeFromSuperview()
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
      menu.setMenuVisible(false, animated: true)
      self.text += text
    }
  }
  
  public func deleteBackward() {
    guard hasText else { return }
    menu.setMenuVisible(false, animated: true)
    text?.removeLast()
  }
}

// MARK: - UITextInput

extension CodeTextField: UITextInput {
  public func replace(_ range: UITextRange, withText text: String) {}
  
  public var selectedTextRange: UITextRange? {
    get { return nil }
    set(selectedTextRange) {}
  }
  
  public var markedTextRange: UITextRange? {
    return nil
  }
  
  public var markedTextStyle: [NSAttributedString.Key : Any]? {
    get { return nil }
    set(markedTextStyle) {}
  }
  
  public func setMarkedText(_ markedText: String?, selectedRange: NSRange) {}
  
  public func unmarkText() {}
  
  public var beginningOfDocument: UITextPosition {
    return UITextPosition()
  }
  
  public var endOfDocument: UITextPosition {
    return UITextPosition()
  }
  
  public func textRange(from fromPosition: UITextPosition, to toPosition: UITextPosition) -> UITextRange? {
    return nil
  }
  
  public func position(from position: UITextPosition, offset: Int) -> UITextPosition? {
    return nil
  }
  
  public func position(from position: UITextPosition, in direction: UITextLayoutDirection, offset: Int) -> UITextPosition? {
    return nil
  }
  
  public func compare(_ position: UITextPosition, to other: UITextPosition) -> ComparisonResult {
    return ComparisonResult.orderedSame
  }
  
  public func offset(from: UITextPosition, to toPosition: UITextPosition) -> Int {
    return 0
  }
  
  public var inputDelegate: UITextInputDelegate? {
    get { return nil }
    set(inputDelegate) {}
  }
  
  public var tokenizer: UITextInputTokenizer {
    return UITextInputStringTokenizer(textInput: self)
  }
  
  public func position(within range: UITextRange, farthestIn direction: UITextLayoutDirection) -> UITextPosition? {
    return nil
  }
  
  public func characterRange(byExtending position: UITextPosition, in direction: UITextLayoutDirection) -> UITextRange? {
    return nil
  }
  
  public func baseWritingDirection(for position: UITextPosition, in direction: UITextStorageDirection) -> UITextWritingDirection {
    return UITextWritingDirection.natural
  }
  
  public func setBaseWritingDirection(_ writingDirection: UITextWritingDirection, for range: UITextRange) {}
  
  public func firstRect(for range: UITextRange) -> CGRect {
    return .zero
  }
  
  public func caretRect(for position: UITextPosition) -> CGRect {
    return .zero
  }
  
  public func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
    return []
  }
  
  public func closestPosition(to point: CGPoint) -> UITextPosition? {
    return nil
  }
  
  public func closestPosition(to point: CGPoint, within range: UITextRange) -> UITextPosition? {
    return nil
  }
  
  public func characterRange(at point: CGPoint) -> UITextRange? {
    return nil
  }
  
  public func text(in range: UITextRange) -> String? {
    return nil
  }
}
