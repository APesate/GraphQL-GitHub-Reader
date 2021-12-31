//
//  ErrorStateable.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 31/12/2021.
//

import CommonUI
import UIKit

protocol ErrorStateable {
  var errorView: ErrorView { get }

  func set(errorModel: ErrorView.Model?)
}

extension ErrorStateable where Self: UIView {
  func set(errorModel: ErrorView.Model?) {
    errorView.removeFromSuperview()

    guard let model = errorModel else {
      return
    }

    errorView.model = model
    addSubview(errorView)

    errorView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      errorView.centerXAnchor.constraint(equalTo: centerXAnchor),
      errorView.centerYAnchor.constraint(equalTo: centerYAnchor),
      errorView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
      errorView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
      trailingAnchor.constraint(greaterThanOrEqualTo: errorView.trailingAnchor),
      bottomAnchor.constraint(greaterThanOrEqualTo: errorView.bottomAnchor),
    ])
  }
}
