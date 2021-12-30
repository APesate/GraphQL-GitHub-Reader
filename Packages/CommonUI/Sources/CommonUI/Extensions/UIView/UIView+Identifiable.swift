//
//  UIView+Identifiable.swift
//  CommonUI
//
//  Created by Andrés Pesate on 29/12/2021.
//

import class UIKit.UIView

public extension UIView {
  static var className: String {
    String(describing: self)
  }
}
