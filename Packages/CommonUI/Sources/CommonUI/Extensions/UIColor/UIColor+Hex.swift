//
//  UIColor+Hex.swift
//  CommonUI
//
//  Created by Andrés Pesate on 29/12/2021.
//

import UIKit.UIColor

public extension UIColor {
  /// Attempts to instantiate an UIColor from the provided HEX number.
  ///
  /// - Parameter hex: Color in hex format without alpha channel.
  /// - Parameter alpha: The alpha value for the color. Defaults to 1.0
  ///
  /// - Returns: If the provided hex was valid, an UIColor that matches the code. `nil` otherwise.
  convenience init?(hex: String, alpha: Double = 1.0) {
    let r, g, b: CGFloat

    if hex.hasPrefix("#") {
      let start = hex.index(hex.startIndex, offsetBy: 1)
      let hexColor = String(hex[start...])

      if hexColor.count == 6 {
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0

        if scanner.scanHexInt64(&hexNumber) {
          r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
          g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
          b = CGFloat(hexNumber & 0x0000FF) / 255

          self.init(red: r, green: g, blue: b, alpha: CGFloat(alpha))
          return
        }
      }
    }

    return nil
  }
}
