//
//  NibView.swift
//  extend
//
//  Created by Aleksey Zgurskiy on 5/7/19.
//  Copyright © 2019 Aleksey Zgurskiy. All rights reserved.
//

import UIKit

open class NibView: UIView, NibLoadable {
  public override init(frame: CGRect) {
    super.init(frame: frame)
    loadNib(type(of: self).nib)
    viewDidInit()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    loadNib(type(of: self).nib)
    viewDidInit()
  }
  
  open func viewDidInit() {}
}

open class NibControl: UIControl, NibLoadable {
  public override init(frame: CGRect) {
    super.init(frame: frame)
    loadNib(type(of: self).nib)?.isUserInteractionEnabled = false
    viewDidInit()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    loadNib(type(of: self).nib)?.isUserInteractionEnabled = false
    viewDidInit()
  }
  
  open func viewDidInit() {}
}
