//
//  UIView+Layout.swift
//  CommonUI
//
//  Created by Andrés Pesate on 29/12/2021.
//

import class UIKit.UIView

public extension UIView {
  static func spacerView() -> UIView {
    let view = UIView()
    view.setContentHuggingPriority(.defaultLow, for: .horizontal)
    return view
  }
}
