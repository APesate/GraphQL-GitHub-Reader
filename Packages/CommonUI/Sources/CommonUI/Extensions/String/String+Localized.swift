//
//  String+Localized.swift
//  CommonUI
//
//  Created by Andrés Pesate on 29/12/2021.
//

import Foundation

public extension String {
  /// Fetches a localised String Arguments
  var localized: String {
    NSLocalizedString(self, comment: "")
  }

  /// Fetches a localised String Arguments
  ///
  /// - Parameter arguments: parameters to be added in a string
  /// - Returns: localized string
  func localized(with arguments: [CVarArg]) -> String {
    String(format: localized, locale: Locale.current, arguments: arguments)
  }
}
